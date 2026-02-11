import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import 'add_task_sheet.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('タスク'),
        centerTitle: false,
      ),
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Center(child: Text('タスクがありません。\n右下のボタンから追加しよう！', textAlign: TextAlign.center));
          }
          
          // Sort: Incomplete first, etc. (Simple impl for now)
          final sortedTasks = List<TaskModel>.from(tasks)
            ..sort((a, b) {
              if (a.isCompleted != b.isCompleted) {
                return a.isCompleted ? 1 : -1;
              }
              // Both incomplete or completed
              // Logic: Expired (Asc) > Today/Tomorrow (Asc) > Future > No Date (n/a here as date required)
              return a.dueDate.compareTo(b.dueDate);
            });

          // Group tasks by date label
          final groupedTasks = <String, List<TaskModel>>{};
          for (final task in sortedTasks) {
            final dateLabel = _getDateLabel(task.dueDate);
            groupedTasks.putIfAbsent(dateLabel, () => []).add(task);
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: groupedTasks.length,
            itemBuilder: (context, index) {
              final label = groupedTasks.keys.elementAt(index);
              final tasksInGroup = groupedTasks[label]!;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  ...tasksInGroup.map((task) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Dismissible(
                      key: Key(task.taskId),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(16)),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.check, color: Colors.green),
                      ),
                      secondaryBackground: Container(
                        decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(16)),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                           await ref.read(taskControllerProvider).completeTask(task);
                           if (context.mounted) {
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(
                                 content: Text('タスク完了！ 10ポイント獲得！ 🐧'),
                                 backgroundColor: Colors.orange,
                                 behavior: SnackBarBehavior.floating,
                                 shape: StadiumBorder(),
                               ),
                             );
                           }
                           return false;
                        } else {
                           return await _confirmDelete(context, ref, task);
                        }
                      },
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: task.isCompleted ? Colors.grey[50] : Colors.white,
                        child: ListTile(
                          onTap: () => _showAddTaskDialog(context, ref, task: task),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(task.categoryId).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(_getCategoryIcon(task.categoryId), color: _getCategoryColor(task.categoryId), size: 20),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                              color: task.isCompleted ? Colors.grey : Colors.black87,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  if (task.dueDate.isBefore(DateTime.now()) && !task.isCompleted)
                                    const Icon(Icons.warning_amber_rounded, size: 14, color: Colors.deepOrange),
                                  Text(
                                    '${DateFormat('MM/dd HH:mm').format(task.dueDate)}',
                                    style: TextStyle(
                                      color: (task.dueDate.isBefore(DateTime.now()) && !task.isCompleted) ? Colors.deepOrange : Colors.grey,
                                      fontSize: 12
                                    ),
                                  ),
                                  if (task.repeatRule != null) ...[
                                    const SizedBox(width: 8),
                                    Icon(Icons.repeat, size: 14, color: Colors.blueGrey[300]),
                                    Text(' ${task.repeatRule!.type}', style: TextStyle(fontSize: 12, color: Colors.blueGrey[300])),
                                  ],
                                ],
                              ),
                              if (task.assigneeId != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Row(
                                    children: [
                                       Icon(Icons.person_outline, size: 14, color: Colors.indigo[300]),
                                       const SizedBox(width: 4),
                                       Text(
                                         '担当あり', // Ideally show name but requires async
                                         style: TextStyle(fontSize: 12, color: Colors.indigo[300]),
                                       ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          trailing: task.isCompleted 
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.circle_outlined, color: Colors.grey[300]),
                        ),
                      ),
                    ),
                  )),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddTaskDialog(context, ref);
        },
        label: const Text('タスク追加'),
        icon: const Icon(Icons.add),
        elevation: 4,
        highlightElevation: 8,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final target = DateTime(date.year, date.month, date.day);

    if (target.isBefore(today)) {
      return '期限切れ';
    } else if (target == today) {
      return '今日';
    } else if (target == tomorrow) {
      return '明日';
    } else {
      return '以降 (${DateFormat('M/d').format(date)})';
    }
  }

  Color _getCategoryColor(String id) {
    switch (id) {
      case 'cleaning': return Colors.teal;
      case 'shopping': return Colors.orange;
      case 'cooking': return Colors.redAccent;
      case 'laundry': return Colors.blue;
      case 'trash': return Colors.brown;
      default: return Colors.indigo;
    }
  }

  IconData _getCategoryIcon(String id) {
    switch (id) {
      case 'cleaning': return Icons.cleaning_services;
      case 'shopping': return Icons.shopping_cart;
      case 'cooking': return Icons.restaurant;
      case 'laundry': return Icons.local_laundry_service;
      case 'trash': return Icons.delete_outline;
      default: return Icons.format_list_bulleted;
    }
  }

  Future<bool> _confirmDelete(BuildContext context, WidgetRef ref, TaskModel task) async {
     final confirm = await showDialog<bool>(
       context: context,
       builder: (context) => AlertDialog(
         title: const Text('タスクを削除'),
         content: const Text('本当に削除しますか？'),
         actions: [
           TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('キャンセル')),
           TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('削除', style: TextStyle(color: Colors.red))),
         ],
       ),
     );
     
     if (confirm == true) {
       await ref.read(taskControllerProvider).deleteTask(task);
       return true;
     }
     return false;
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref, {TaskModel? task}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // For clean look
      builder: (context) => AddTaskSheet(task: task),
    );
  }
}

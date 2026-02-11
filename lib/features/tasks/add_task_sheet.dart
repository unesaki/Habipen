import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/task_model.dart';
import '../../models/user_model.dart';
import '../../providers/task_provider.dart';
import '../../providers/user_provider.dart';
import '../../core/firestore_repository.dart';

class AddTaskSheet extends ConsumerStatefulWidget {
  final TaskModel? task;
  const AddTaskSheet({super.key, this.task});

  @override
  ConsumerState<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends ConsumerState<AddTaskSheet> {
  late TextEditingController _titleController;
  final _today = DateTime.now();
  
  late DateTime _selectedDate;
  String _categoryId = 'cleaning'; // default icon
  String _categoryName = '掃除'; // default name
  String? _assigneeId; // null = anyone
  String _repeatType = 'none'; // none, daily, weekly, monthly
  
  List<UserModel> _groupMembers = [];
  bool _isLoadingMembers = true;

  final Map<String, IconData> _categories = {
    'cleaning': Icons.cleaning_services,
    'shopping': Icons.shopping_cart,
    'cooking': Icons.restaurant,
    'laundry': Icons.local_laundry_service,
    'trash': Icons.delete_outline,
    'other': Icons.format_list_bulleted,
  };

  final Map<String, String> _categoryNames = {
    'cleaning': '掃除',
    'shopping': '買い物',
    'cooking': '料理',
    'laundry': '洗濯',
    'trash': 'ゴミ出し',
    'other': 'その他',
  };

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    
    // Init with task data if provided
    final t = widget.task;
    _titleController = TextEditingController(text: t?.title ?? '');
    
    if (t != null) {
      _selectedDate = t.dueDate;
      _categoryId = t.categoryId;
      _categoryName = t.categoryName;
      _assigneeId = t.assigneeId;
      _repeatType = t.repeatRule?.type ?? 'none';
    } else {
      _selectedDate = DateTime(_today.year, _today.month, _today.day);
    }

    // Use addPostFrameCallback to safely access ref and context if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMembers();
    });
  }

  Future<void> _fetchMembers() async {
    try {
      final groupAsync = ref.read(currentGroupProvider);
      final group = groupAsync.value;
      
      if (group != null && group.members.isNotEmpty) {
        final repo = ref.read(firestoreRepositoryProvider);
        final members = await repo.fetchUsers(group.members);
        if (mounted) {
          setState(() {
            _groupMembers = members;
            _isLoadingMembers = false;
          });
        }
      } else {
         if (mounted) setState(() => _isLoadingMembers = false);
      }
    } catch (e) {
      debugPrint('Error fetching members: $e');
      if (mounted) setState(() => _isLoadingMembers = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 20, 
        right: 20, 
        top: 24
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Drag Handle & Title
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 20),

          // 1. Clean Title Input
          TextField(
            controller: _titleController,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: '新しいタスクを入力',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            autofocus: !isEdit,
          ),
          const SizedBox(height: 20),
          
          // 2. Options Row (Category, Date, Assignee, Repeat)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Category
                _buildOptionChip(
                  label: _categoryName,
                  icon: _categories[_categoryId] ?? Icons.error,
                  onTap: _showCategoryPicker,
                  color: _categoryId == 'cleaning' ? Colors.teal[50] : Colors.grey[100], // Example dynamic color
                  iconColor: _categoryId == 'cleaning' ? Colors.teal : Colors.grey[700],
                ),
                const SizedBox(width: 8),
                
                // Date
                _buildOptionChip(
                  label: _formatDate(_selectedDate),
                  icon: Icons.calendar_today,
                  onTap: _showDatePicker,
                  isHighlight: _selectedDate.isBefore(_today) && !_isSameDay(_selectedDate, _today),
                ),
                const SizedBox(width: 8),
                
                // Assignee
                _buildOptionChip(
                  label: _assigneeId == null 
                      ? '担当なし' 
                      : (_groupMembers.firstWhere((u) => u.uid == _assigneeId, orElse: () => UserModel(
                          uid: '', 
                          name: '不明', 
                          currentPoints: 0, 
                          groupId: '',
                          createdAt: DateTime.now()
                        )).name),
                  icon: Icons.person_outline,
                  onTap: _showAssigneePicker,
                  color: _assigneeId != null ? Colors.indigo[50] : Colors.grey[100],
                  iconColor: _assigneeId != null ? Colors.indigo : Colors.grey[700],
                ),
                 const SizedBox(width: 8),

                // Repeat
                _buildOptionChip(
                  label: _repeatType == 'none' 
                      ? '繰り返しなし' 
                      : (_repeatType == 'daily' ? '毎日' : (_repeatType == 'weekly' ? '毎週' : '毎月')),
                  icon: Icons.repeat,
                  onTap: _showRepeatPicker,
                  color: _repeatType != 'none' ? Colors.blue[50] : Colors.grey[100],
                  iconColor: _repeatType != 'none' ? Colors.blue : Colors.grey[700],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Action Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isEdit)
                IconButton(
                  onPressed: _deleteTask,
                  icon: const Icon(Icons.delete_outline, color: Colors.grey),
                  tooltip: '削除',
                )
              else
                const SizedBox(width: 48), // Spacer
              
              ElevatedButton.icon(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                icon: const Icon(Icons.send),
                label: Text(isEdit ? '保存' : '追加', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper for Assignee Picker
  void _showAssigneePicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(title: const Text('担当なし'), onTap: () { setState(() => _assigneeId = null); Navigator.pop(ctx); }),
          ..._groupMembers.map((u) => ListTile(
            title: Text(u.name), 
            leading: CircleAvatar(child: Text(u.name[0])),
            onTap: () { setState(() => _assigneeId = u.uid); Navigator.pop(ctx); },
          ))
        ],
      )
    );
  }

  // Helper for Repeat Picker
  void _showRepeatPicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text('繰り返し設定', style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(leading: const Icon(Icons.close), title: const Text('なし'), onTap: () { setState(() => _repeatType = 'none'); Navigator.pop(ctx); }),
          ListTile(leading: const Icon(Icons.today), title: const Text('毎日'), onTap: () { setState(() => _repeatType = 'daily'); Navigator.pop(ctx); }),
          ListTile(leading: const Icon(Icons.calendar_view_week), title: const Text('毎週'), onTap: () { setState(() => _repeatType = 'weekly'); Navigator.pop(ctx); }),
          ListTile(leading: const Icon(Icons.calendar_month), title: const Text('毎月'), onTap: () { setState(() => _repeatType = 'monthly'); Navigator.pop(ctx); }),
          const SizedBox(height: 16),
        ],
      )
    );
  }

  // ... (Keep existing helpers _buildOptionChip, _showDatePicker, _showCategoryPicker, _formatDate, _isSameDay) ...
  Widget _buildOptionChip({
    required String label, 
    required IconData icon, 
    required VoidCallback onTap,
    bool isHighlight = false,
    Color? color,
    Color? iconColor,
  }) {
    // If specific color provided, use it. Else fall back to highlight logic or default.
    final bgColor = color ?? (isHighlight ? Colors.red[50] : Colors.grey[100]);
    final fgColor = iconColor ?? (isHighlight ? Colors.red : Colors.black87);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: isHighlight ? Border.all(color: Colors.red) : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: fgColor),
            const SizedBox(width: 8),
            Text(
              label, 
              style: TextStyle(
                color: fgColor,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showCategoryPicker() {
    final nameController = TextEditingController(text: _categoryName);
    String tempCatId = _categoryId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // For keyboard
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16, right: 16, top: 16
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('カテゴリ設定', 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'カテゴリ名（任意）',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: _categories.entries.map((e) {
                      final isSelected = tempCatId == e.key;
                      return InkWell(
                        onTap: () {
                          setModalState(() {
                            tempCatId = e.key;
                            // Update name to default if user hasn't typed something custom?
                            // Or just force update. Let's force update for convenience.
                            nameController.text = _categoryNames[e.key]!;
                          });
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: isSelected ? Colors.indigo[100] : Colors.grey[200],
                              child: Icon(e.value, 
                                color: isSelected ? Colors.indigo : Colors.grey,
                                size: 24
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(_categoryNames[e.key]!, style: const TextStyle(fontSize: 10), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final newName = nameController.text.trim().isEmpty 
                        ? _categoryNames[tempCatId]! 
                        : nameController.text.trim();
                    setState(() {
                      _categoryId = tempCatId;
                      _categoryName = newName;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('決定'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }
      ),
    );
  }

  String _formatDate(DateTime date) {
    if (_isSameDay(date, _today)) return '今日';
    final tomorrow = _today.add(const Duration(days: 1));
    if (_isSameDay(date, tomorrow)) return '明日';
    return DateFormat('MM/dd').format(date);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    RepeatRule? rule;
    if (_repeatType != 'none') {
      rule = RepeatRule(type: _repeatType, weekdays: [_selectedDate.weekday]);
    }

    try {
      if (widget.task != null) {
        // Validation: Create new task model from old one + changes
        final updatedTask = widget.task!.copyWith(
          title: title,
          categoryId: _categoryId,
          categoryName: _categoryName,
          assigneeId: _assigneeId,
          dueDate: _selectedDate,
          repeatRule: rule,
        );
        await ref.read(taskControllerProvider).updateTask(updatedTask);
      } else {
        await ref.read(taskControllerProvider).addTask(
          title: title,
          categoryId: _categoryId,
          categoryName: _categoryName,
          assigneeId: _assigneeId,
          dueDate: _selectedDate,
          repeatRule: rule,
        );
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _deleteTask() async {
    if (widget.task == null) return;
    try {
      await ref.read(taskControllerProvider).deleteTask(widget.task!);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}

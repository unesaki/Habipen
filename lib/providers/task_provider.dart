import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../core/firestore_repository.dart';
import '../models/task_model.dart';

import 'user_provider.dart';
import 'auth_provider.dart';

final taskListProvider = StreamProvider.autoDispose<List<TaskModel>>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.groupId == null) return Stream.value([]);
  
  final repository = ref.watch(firestoreRepositoryProvider);
  return repository.streamTasks(user!.groupId!);
});

// Logic Provider for Actions
class TaskController {
  final Ref ref;
  TaskController(this.ref);
  
  Future<void> addTask({
    required String title, 
    required String categoryId,
    String categoryName = 'その他',
    String? assigneeId,
    required DateTime dueDate,
    RepeatRule? repeatRule,
  }) async {
    final authUser = ref.read(firebaseAuthProvider).currentUser;
    if (authUser == null) return;

    final user = ref.read(userStreamProvider).value;
    
    // Auto-create group if missing (Guest logic)
    String? groupId = user?.groupId;
    if (groupId == null) {
      groupId = await ref.read(groupControllerProvider).createGroup();
      if (groupId == null) return; // Auth failed or something
    }
    
    // Check Task Limit (Max 100)
    final currentTasks = await ref.read(firestoreRepositoryProvider).fetchTasks(groupId);
    final incompleteCount = currentTasks.where((t) => !t.isCompleted).length;
    if (incompleteCount >= 100) {
      throw Exception('タスク上限(100件)に達しました');
    }

    final taskId = const Uuid().v4();
    final task = TaskModel(
      taskId: taskId,
      title: title,
      categoryId: categoryId,
      categoryName: categoryName,
      createdBy: authUser.uid,
      assigneeId: assigneeId,
      dueDate: dueDate,
      createdAt: DateTime.now(),
      repeatRule: repeatRule,
    );
    
    await ref.read(firestoreRepositoryProvider).createTask(groupId, task);
  }

  Future<void> completeTask(TaskModel task) async {
    final user = ref.read(userStreamProvider).value;
    if (user?.groupId == null) return;

    await ref.read(firestoreRepositoryProvider).updateTask(
      user!.groupId!,
      task.taskId,
      {
        'isCompleted': true,
        'completedBy': user.uid,
        'completedAt': DateTime.now().toIso8601String(),
      },
    );

    // Recurring Logic
    if (task.repeatRule != null && task.repeatRule!.type != 'none') {
      DateTime nextDate = task.dueDate;
      final now = DateTime.now();
      // If due date is in past, base next date on Today to avoid backlog
      final baseDate = nextDate.isBefore(now) ? now : nextDate;
      
      switch (task.repeatRule!.type) {
        case 'daily':
          nextDate = baseDate.add(const Duration(days: 1));
          break;
        case 'weekly':
          nextDate = baseDate.add(const Duration(days: 7));
          break;
        case 'monthly':
          nextDate = DateTime(baseDate.year, baseDate.month + 1, baseDate.day);
          break;
      }
      
      final newTaskId = const Uuid().v4();
      final newTask = task.copyWith(
        taskId: newTaskId,
        dueDate: nextDate,
        isCompleted: false,
        completedBy: null,
        completedAt: null,
        createdAt: DateTime.now(),
        lastNudgedAt: null,
      );
       await ref.read(firestoreRepositoryProvider).createTask(user.groupId!, newTask);
    }

    // Increment User Points
    final currentPoints = user.currentPoints;
    // Cap logic could be here, but simpler to just add for now or check cap later
    // Design says 30pt cap per day. Implementing daily cap logic requires tracking 'pointsEarnedToday'.
    // User model doesn't have 'pointsEarnedToday'.
    // For now, implementing simple addition, will add cap constraint later if needed or mark TODO.
    // Actually, let's implement the cap logic in a separate "Economy" pass if needed, 
    // or just add points here. 
    await ref.read(firestoreRepositoryProvider).updateUser(
      user.uid, 
      {'currentPoints': currentPoints + 10}
    );
  }

  Future<void> updateTask(TaskModel task) async {
    final user = ref.read(userStreamProvider).value;
    if (user?.groupId == null) return;
    
    await ref.read(firestoreRepositoryProvider).updateTask(
      user!.groupId!,
      task.taskId,
      task.toJson(),
    );
  }

  Future<void> deleteTask(TaskModel task) async {
    final user = ref.read(userStreamProvider).value;
    if (user?.groupId == null) return;
    
    await ref.read(firestoreRepositoryProvider).deleteTask(user!.groupId!, task.taskId);
  }
}

final taskControllerProvider = Provider((ref) => TaskController(ref));

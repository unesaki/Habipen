import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/task_provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';
import '../../models/task_model.dart';
import '../../models/group_model.dart';

import 'room_layer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userStreamProvider);
    final groupAsync = ref.watch(currentGroupProvider);
    final tasksAsync = ref.watch(taskListProvider);
    final groupMembersAsync = ref.watch(groupMembersProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        children: [
          // 1. Room Layer (Background - Full Screen)
          Positioned.fill(
            child: groupMembersAsync.when(
              data: (members) => tasksAsync.when(
                data: (tasks) => RoomWidget(members: members, tasks: tasks),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
            ),
          ),

          // 2. Top Status Bar (Overlay)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: 80,
                child: _buildHeader(context, userAsync, tasksAsync),
              ),
            ),
          ),

          // 3. Bottom Group Info (Overlay)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 80,
                child: _buildFooter(context, groupAsync, ref),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AsyncValue<UserModel?> userAsync, AsyncValue<List<TaskModel>> tasksAsync) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Points / Level
          userAsync.when(
            data: (user) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    'Lv.${(user?.currentPoints ?? 0) ~/ 100 + 1}  |  ${user?.currentPoints ?? 0} pt',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox(),
            error: (_,__) => const SizedBox(),
          ),

          // Remaining Tasks
          tasksAsync.when(
            data: (tasks) {
              final remaining = tasks.where((t) => !t.isCompleted).length;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: remaining > 0 ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
                ),
                child: Row(
                  children: [
                    Icon(
                      remaining > 0 ? Icons.assignment_late_outlined : Icons.assignment_turned_in_outlined, 
                      color: remaining > 0 ? Colors.red : Colors.green, 
                      size: 18
                    ),
                    const SizedBox(width: 4),
                    Text(
                      remaining > 0 ? 'あと $remaining つ' : '全完了!',
                      style: TextStyle(
                        fontSize: 12, 
                        fontWeight: FontWeight.bold,
                        color: remaining > 0 ? Colors.red[800] : Colors.green[800]
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox(),
            error: (_,__) => const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AsyncValue<GroupModel?> groupAsync, WidgetRef ref) {
    return groupAsync.when(
      data: (group) {
        if (group == null) {
          return Center(
            child: ElevatedButton(
              onPressed: () => ref.read(groupControllerProvider).createGroup(),
              child: const Text('グループを作成して開始'),
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.home_work_rounded, size: 20, color: Colors.indigo),
                const SizedBox(width: 8),
                const Text('Invite ID:', style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                SelectableText(
                  group.inviteId,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.indigo, letterSpacing: 1.0),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 18, color: Colors.black54),
                  onPressed: () {}, // Add copy logic if needed
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Copy ID',
                )
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox(),
      error: (_,__) => const SizedBox(),
    );
  }
}



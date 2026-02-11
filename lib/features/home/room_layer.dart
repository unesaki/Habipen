import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/user_model.dart';
import '../../models/task_model.dart';

class RoomWidget extends StatelessWidget {
  final List<UserModel> members;
  final List<TaskModel> tasks;

  const RoomWidget({
    super.key,
    required this.members,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background (Cozy Room)
          Image.asset(
            'images/bg_room_penguin.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),

          // 2. Touch Area & Bubble for Single User
          // Position relative to the background's character 
          // Character is roughly at Bottom-Right quadrant.
          // Using Align for responsiveness.
          
          if (members.isNotEmpty)
             _buildSinglePenguinInteraction(context, members.first),
          
          // Note: If multiple members, we might just show bubbles for others?
          // But user said "Use this image" (singular penguin).
          // So likely this is a solo view or we just overlay others?
          // For now, let's assume single user focus as per "Home Screen" design.
        ],
      ),
    );
  }

  Widget _buildSinglePenguinInteraction(BuildContext context, UserModel user) {
      final userTasks = tasks.where((t) => 
        !t.isCompleted && (t.assigneeId == user.uid || t.assigneeId == null)
      ).toList();

      return Align(
        alignment: const Alignment(0.5, 0.5), // Adjust this validation
        child: FractionallySizedBox(
          widthFactor: 0.5, // Cover right half?
          heightFactor: 0.5, // Cover bottom half?
          child: Stack(
            children: [
              // Bubble & HitBox
              // We need specific coordinates.
              // Let's use a positioned widget within this "quadrant".
              LayoutBuilder(builder: (context, constraints) {
                 // Trying to hit the armchair area.
                 // In a 100x100 box of the "Bottom Right Quadrant":
                 // Penguin head is roughly top-left of this quadrant? 
                 // We need to verify with screenshot.
                 // Let's place the Bubble/Touch widget.
                 return Stack(
                   children: [
                     Positioned(
                       bottom: 80, 
                       right: 40,
                       child: _PenguinBubble(
                         user: user,
                         taskCount: userTasks.length,
                         memberTasks: userTasks,
                       ),
                     ),
                   ],
                 );
              }),
            ],
          ),
        ),
      );
  }

  // _buildPenguins removed as we use static background
  List<Widget> _buildPenguins(BuildContext context) => [];
}

class _PenguinBubble extends StatefulWidget {
  final UserModel user;
  final int taskCount;
  final List<TaskModel> memberTasks;

  const _PenguinBubble({
    required this.user,
    required this.taskCount,
    required this.memberTasks,
  });

  @override
  State<_PenguinBubble> createState() => _PenguinBubbleState();
}

class _PenguinBubbleState extends State<_PenguinBubble> {
  bool _showBubble = true;
  String _bubbleText = '';
  
  @override
  void initState() {
    super.initState();
    _determineBubbleText();
    // Auto-hide after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showBubble = false);
    });
  }
  
  void _determineBubbleText() {
    // 1. Tasks >= 3
    if (widget.taskCount >= 3) {
      _bubbleText = 'うわぁ、タスクがいっぱい…！';
      return;
    }
    
    // 4. Login > 2 days
    if (widget.user.lastLoginAt != null) {
      final diff = DateTime.now().difference(widget.user.lastLoginAt!);
      if (diff.inDays >= 2) {
        _bubbleText = '久しぶり！元気だった？';
        return;
      }
    }

    // 5. Task added < 2h & First time
    if (widget.memberTasks.isNotEmpty) {
      if (widget.memberTasks.length == 1) {
        final task = widget.memberTasks.first;
        final diff = DateTime.now().difference(task.createdAt);
        if (diff.inHours < 2) {
          _bubbleText = 'はじめまして！よろしくね🐧';
          return;
        }
      }
    }

    // 2. Tasks 1-2
    if (widget.taskCount > 0 && widget.taskCount <= 2) {
      _bubbleText = 'あとちょっと！頑張ろう';
      return;
    }
    
    // 3. Tasks 0
    if (widget.taskCount == 0) {
      _bubbleText = '全部終わったね！のんびりしよ〜';
      return;
    }
    
    _bubbleText = '...';
  }

  void _toggleBubble() {
    if (_showBubble) {
      setState(() => _showBubble = false);
    } else {
      _determineBubbleText();
      setState(() => _showBubble = true);
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) setState(() => _showBubble = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Bubble
        AnimatedOpacity(
          opacity: _showBubble ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () {
               if (_showBubble) {
                 context.go('/tasks');
               }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              constraints: const BoxConstraints(maxWidth: 160),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0), // Warm beige/orange tint
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0), // Speech tail
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
                border: Border.all(color: Colors.orange.shade100, width: 1.5),
              ),
              child: Text(
                _bubbleText,
                style: const TextStyle(
                  fontSize: 13, 
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037), // Warm Brown text
                  fontFamily: 'Noto Sans JP',
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        
        // Transparent Touch Area (HitBox over Penguin)
        GestureDetector(
          onTap: _toggleBubble,
          child: Container(
            width: 140, 
            height: 140,
            color: Colors.transparent, // Invisible hit box
          ),
        ),
      ],
    );
  }
}

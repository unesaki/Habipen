import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/firestore_repository.dart';
import '../models/user_model.dart';
import '../models/group_model.dart';
import 'auth_provider.dart';

final userStreamProvider = StreamProvider<UserModel?>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) return Stream.value(null);
  
  final repository = ref.watch(firestoreRepositoryProvider);
  return repository.streamUser(uid);
});

final currentGroupProvider = StreamProvider.autoDispose<GroupModel?>((ref) {
  final userAsync = ref.watch(userStreamProvider);
  
  return userAsync.when(
    data: (user) {
      if (user?.groupId == null) return Stream.value(null);
      final repository = ref.watch(firestoreRepositoryProvider);
      return repository.streamGroup(user!.groupId!);
    },
    loading: () => Stream.value(null),
    error: (_, __) => Stream.value(null),
  );
});

final groupMembersProvider = StreamProvider.autoDispose<List<UserModel>>((ref) {
  final user = ref.watch(userStreamProvider).value;
  if (user?.groupId == null) return Stream.value([]);
  
  final repository = ref.watch(firestoreRepositoryProvider);
  return repository.streamGroupMembers(user!.groupId!);
});

class GroupController {
  final Ref ref;
  GroupController(this.ref);

  Future<String?> createGroup() async {
    final authUser = ref.read(firebaseAuthProvider).currentUser;
    if (authUser == null) return null;

    final repository = ref.read(firestoreRepositoryProvider);
    var user = ref.read(userStreamProvider).value;

    // Self-healing: If Firestore doc doesn't exist, create it now.
    if (user == null) {
      final newUser = UserModel(
        uid: authUser.uid,
        name: 'ゲスト', // This might overwrite display name if we aren't careful, but fine for now
        groupId: null,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
      await repository.createUser(newUser);
      user = newUser; 
    }
    
    if (user.groupId != null) return user.groupId; // Already in group

    final newGroupId = const Uuid().v4();
    
    // Create Group
    final group = GroupModel(
      groupId: newGroupId,
      members: [authUser.uid],
      inviteId: const Uuid().v4().substring(0, 8),
      createdAt: DateTime.now(),
    );
    await repository.createGroup(group);

    // Update User with new Group ID
    await repository.updateUser(authUser.uid, {'groupId': newGroupId});
    
    return newGroupId;
  }

  Future<void> joinGroup(String inviteId) async {
    final authUser = ref.read(firebaseAuthProvider).currentUser;
    if (authUser == null) throw Exception('User not logged in');

    final repository = ref.read(firestoreRepositoryProvider);
    
    // Find Group
    final group = await repository.getGroupByInviteId(inviteId);
    if (group == null) {
      throw Exception('Group not found');
    }

    // Ensure User Doc Exists (Self-healing similar to create)
    var user = ref.read(userStreamProvider).value;
    if (user == null) {
       final newUser = UserModel(
        uid: authUser.uid,
        name: 'ゲスト',
        groupId: null,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
      await repository.createUser(newUser);
    } else if (user.groupId != null) {
      throw Exception('Already in a group');
    }

    // Update Group Members
    final newMembers = [...group.members, authUser.uid];
    await repository.updateGroup(group.groupId, {'members': newMembers});

    // Update User
    await repository.updateUser(authUser.uid, {'groupId': group.groupId});
    await repository.updateUser(authUser.uid, {'groupId': group.groupId});
  }

  Future<void> updateLastLogin() async {
    final authUser = ref.read(firebaseAuthProvider).currentUser;
    if (authUser == null) return;
    try {
      await ref.read(firestoreRepositoryProvider).updateUser(
        authUser.uid, 
        {'lastLoginAt': Timestamp.now()} 
      );
    } catch (_) {}
  }
}

final groupControllerProvider = Provider((ref) => GroupController(ref));

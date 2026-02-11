import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../models/group_model.dart';
import '../models/task_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore;
  FirestoreRepository(this._firestore);

  // --- Users ---
  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  Stream<UserModel?> streamUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data()!);
    });
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  Future<List<UserModel>> fetchUsers(List<String> uids) async {
    if (uids.isEmpty) return [];
    // Firestore 'in' query supports up to 10 items. 
    // For larger groups, we might need multiple queries, but max group size is 5.
    final snapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: uids)
        .get();
    
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Stream<List<UserModel>> streamGroupMembers(String groupId) {
    return _firestore
        .collection('users')
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) {
              try {
                return UserModel.fromJson(doc.data());
              } catch (e) {
                // print('Error parsing user: $e');
                return null;
              }
            }).whereType<UserModel>().toList());
  }

  // --- Groups ---
  Future<void> createGroup(GroupModel group) async {
    await _firestore.collection('groups').doc(group.groupId).set(group.toJson());
  }

  Stream<GroupModel?> streamGroup(String groupId) {
    return _firestore.collection('groups').doc(groupId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return GroupModel.fromJson(doc.data()!);
    });
  }

  Future<void> updateGroup(String groupId, Map<String, dynamic> data) async {
    await _firestore.collection('groups').doc(groupId).update(data);
  }

  Future<GroupModel?> getGroupByInviteId(String inviteId) async {
    final snapshot = await _firestore
        .collection('groups')
        .where('inviteId', isEqualTo: inviteId)
        .limit(1)
        .get();
        
    if (snapshot.docs.isEmpty) return null;
    return GroupModel.fromJson(snapshot.docs.first.data());
  }

  // --- Tasks ---
  Stream<List<TaskModel>> streamTasks(String groupId) {
    return _firestore
        .collection('groups')
        .doc(groupId)
        .collection('tasks')
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        try {
          return TaskModel.fromJson(doc.data());
        } catch (e) {
          // Skip invalid tasks
          // print('Error parsing task: ${doc.id} $e');
          return null;
        }
      }).whereType<TaskModel>().toList();
    });
  }

  Future<List<TaskModel>> fetchTasks(String groupId) async {
    final snapshot = await _firestore
        .collection('groups')
        .doc(groupId)
        .collection('tasks')
        .get();
    return snapshot.docs.map((doc) {
      try {
        return TaskModel.fromJson(doc.data());
      } catch (e) {
        return null;
      }
    }).whereType<TaskModel>().toList();
  }

  Future<void> createTask(String groupId, TaskModel task) async {
    await _firestore
        .collection('groups')
        .doc(groupId)
        .collection('tasks')
        .doc(task.taskId)
        .set(task.toJson());
        
    // Note: Task count increment is handled by Cloud Functions trigger, 
    // but for immediate UI feedback or offline support, we might optimistically update locally if desired.
  }

  Future<void> updateTask(String groupId, String taskId, Map<String, dynamic> data) async {
    await _firestore
        .collection('groups')
        .doc(groupId)
        .collection('tasks')
        .doc(taskId)
        .update(data);
  }

  Future<void> deleteTask(String groupId, String taskId) async {
    await _firestore
        .collection('groups')
        .doc(groupId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});

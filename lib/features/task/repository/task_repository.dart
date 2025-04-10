import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/features/task/models/task_model.dart';

class TaskRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String uid) {
    return _db
        .collection('tasks')
        .where(
          Filter.or(
            Filter('sharedWith', arrayContains: uid),
            Filter('ownerId', isEqualTo: uid),
          ),
        )
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => Task.fromJson(doc.data(), doc.id))
                  .toList(),
        );
  }

  Future<void> addTask(Task task) async {
    await _db.collection('tasks').add(task.toJson());
  }

  Future<void> updateTask(Task task) async {
    await _db.collection('tasks').doc(task.id).update(task.toJson());
  }

  Future<void> toggleComplete(Task task) async {
    await _db.collection('tasks').doc(task.id).update({
      'isCompleted': !task.isCompleted,
    });
  }

  Future<void> shareTask(String taskId, String email) async {
    final userDoc =
        await _db
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

    if (userDoc.docs.isNotEmpty) {
      final uid = userDoc.docs.first.id;
      await _db.collection('tasks').doc(taskId).update({
        'sharedWith': FieldValue.arrayUnion([uid]),
      });
    }
  }
}

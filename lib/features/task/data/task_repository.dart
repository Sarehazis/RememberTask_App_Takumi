// task_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_task/models/task_data.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mengubah ke Stream untuk mendengarkan perubahan data secara real-time
  Stream<List<TaskData>> getTasks() {
    return _firestore.collection('tasks').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => TaskData.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  Future<void> addTask(TaskData task) async {
    final docRef = await _firestore.collection('tasks').add(task.toMap());
    print('Task added with ID: ${docRef.id}');
  }

  Future<void> updateTask(TaskData task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).update(task.toMap());
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }
}

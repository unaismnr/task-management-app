import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tast_management_app/models/task_model.dart';

class TaskService {
  final _tasks = FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(
    TaskModel task,
  ) async {
    try {
      await _tasks.add(task.toDocument());
    } catch (e) {
      log('Firestore Add Error: $e');
    }
  }

  Stream<List<TaskModel>> readTasks() {
    return _tasks.orderBy('time', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) => TaskModel.fromDocument(doc),
            )
            .toList();
      },
    );
  }

  Future<void> updateTask(
    String docId,
    TaskModel task,
  ) async {
    try {
      await _tasks.doc(docId).update(
            task.toDocument(),
          );
    } catch (e) {
      log('Firestore Update Error: $e');
    }
  }

  Future<void> updateTaskStatus(
    String docId,
    bool completionStatus,
  ) async {
    _tasks.doc(docId).update({
      'completionStatus': completionStatus,
    });
  }

  Future<void> deleteTask(
    String docId,
  ) async {
    try {
      await _tasks.doc(docId).delete();
    } catch (e) {
      log('Firestore Delete Error: $e');
    }
  }
}

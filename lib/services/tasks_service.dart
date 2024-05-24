import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final _tasks = FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(
    String title,
    String description,
    DateTime dueDate,
    bool completionStatus,
    double expTaskDuration,
  ) async {
    _tasks.add({
      'title': title,
      'description': description,
      'deadline': dueDate,
      'completionStatus': completionStatus,
      'expectedTaskDuration': expTaskDuration,
      'time': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> readTasks() {
    return _tasks.orderBy('time').snapshots();
  }
}

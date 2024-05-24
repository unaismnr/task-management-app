import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final _tasks = FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(QueryDocumentSnapshot addTaskData) async {
    _tasks.add({
      'title': addTaskData['title'],
      'description': addTaskData['description'],
      'deadline': addTaskData['deadline'],
      'completionStatus': addTaskData['completionStatus'],
      'expectedTaskDuration': addTaskData['expectedTaskDuration'],
      'time': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> readTasks() {
    return _tasks.orderBy('time').snapshots();
  }
}

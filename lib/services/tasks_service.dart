import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final _tasks = FirebaseFirestore.instance.collection('tasks');

  Stream<QuerySnapshot> readTasks() {
    return _tasks.orderBy('time').snapshots();
  }
}

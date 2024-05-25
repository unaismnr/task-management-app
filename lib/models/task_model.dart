import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String title;
  String description;
  String dueDate;
  bool completionStatus;
  String expTaskDuration;
  String? time;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.completionStatus,
    required this.expTaskDuration,
    this.time,
  });

  factory TaskModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      dueDate: data['deadline'],
      completionStatus: data['completionStatus'],
      expTaskDuration: data['expectedTaskDuration'],
      time: Timestamp.now().toString(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'description': description,
      'deadline': dueDate,
      'completionStatus': completionStatus,
      'expectedTaskDuration': expTaskDuration,
      'time': Timestamp.now(),
    };
  }
}

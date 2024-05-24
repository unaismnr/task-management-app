import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tast_management_app/services/tasks_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/utils/other_consts.dart';

class AddUpdateTask extends StatefulWidget {
  const AddUpdateTask({
    super.key,
    this.taskData,
  });

  final QueryDocumentSnapshot? taskData;

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  final taskService = TaskService();
  final GlobalKey<FormState> _formKey = GlobalKey();

  late TextEditingController admissionController;
  late TextEditingController nameController;
  late TextEditingController attendanceController;
  late TextEditingController leaveController;

  @override
  void initState() {
    super.initState();
    admissionController =
        TextEditingController(text: widget.taskData?['admission'] ?? '');
    nameController =
        TextEditingController(text: widget.taskData?['name'] ?? '');
    attendanceController =
        TextEditingController(text: widget.taskData?['attendance'] ?? '');
    leaveController =
        TextEditingController(text: widget.taskData?['leave'] ?? '');
  }

  @override
  void dispose() {
    admissionController.dispose();
    nameController.dispose();
    attendanceController.dispose();
    leaveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.taskData == null ? 'Add Task' : 'Edit Task',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 0,
                      )
                    ]),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldContainer(
                        textController: admissionController,
                        hintText: 'Addmission No',
                      ),
                      kHeight10,
                      TextFieldContainer(
                        textController: nameController,
                        hintText: 'Name',
                        keyboardType: TextInputType.name,
                      ),
                      kHeight10,
                      TextFieldContainer(
                        textController: attendanceController,
                        hintText: 'Attendance',
                      ),
                      kHeight10,
                      TextFieldContainer(
                        textController: leaveController,
                        hintText: 'Leave',
                      ),
                      kHeight20,
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.taskData == null
                                ? addStudent()
                                : editStudent(widget.taskData!.id);
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(
                          Icons.check_circle_outline,
                          color: kWhiteColor,
                        ),
                        label: const Text(
                          'ADD TASK',
                          style: TextStyle(
                            fontSize: 17,
                            color: kWhiteColor,
                          ),
                        ),
                        style: ButtonStyle(
                          elevation: const MaterialStatePropertyAll(0),
                          backgroundColor:
                              const MaterialStatePropertyAll(kMainColor),
                          minimumSize: MaterialStatePropertyAll(
                            Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.065),
                          ),
                          shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addStudent() {
    final admission = admissionController.text.trim();
    final name = nameController.text.trim();
    final attendance = attendanceController.text.trim();
    final leave = leaveController.text.trim();
    if (admission.isEmpty) {
      return;
    }
    if (name.isEmpty) {
      return;
    }
    if (attendance.isEmpty) {
      return;
    }
    if (leave.isEmpty) {
      return;
    }
  }

  void editStudent(docId) {
    final admission = admissionController.text.trim();
    final name = nameController.text.trim();
    final attendance = attendanceController.text.trim();
    final leave = leaveController.text.trim();
    if (admission.isEmpty) {
      return;
    }
    if (name.isEmpty) {
      return;
    }
    if (attendance.isEmpty) {
      return;
    }
    if (leave.isEmpty) {
      return;
    }
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.textController,
    required this.hintText,
    this.keyboardType = TextInputType.number,
  });

  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kBlackColor.withOpacity(0.05),
      ),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          hintText: hintText,
          hintStyle: TextStyle(
            color: kBlackColor.withOpacity(0.4),
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: kBlackColor,
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Details';
          }
          return null;
        },
      ),
    );
  }
}

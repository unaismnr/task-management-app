import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tast_management_app/services/tasks_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/view/common/space_sizedbox.dart';
import 'package:intl/intl.dart';

class AddUpdateTask extends StatefulWidget {
  const AddUpdateTask({super.key, this.taskData});

  final QueryDocumentSnapshot? taskData;

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  final taskService = TaskService();
  final GlobalKey<FormState> _formKey = GlobalKey();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController expTimeController;
  late ValueNotifier<DateTime?> _dueDateNotifier;
  late ValueNotifier<bool?> _isTaskCompletedNotifier;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.taskData?['admission'] ?? '');
    descriptionController =
        TextEditingController(text: widget.taskData?['name'] ?? '');
    expTimeController =
        TextEditingController(text: widget.taskData?['attendance'] ?? '');
    _dueDateNotifier = ValueNotifier<DateTime?>(null);
    _isTaskCompletedNotifier = ValueNotifier<bool>(
      widget.taskData?['completionStatus'] ?? false,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    expTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.taskData == null ? 'Add Task' : 'Edit Task',
          style: const TextStyle(
            color: kWhiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 10,
                      spreadRadius: 0,
                    )
                  ]),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldContainer(
                      textController: titleController,
                      hintText: 'Title',
                    ),
                    const SpaceSizedBox(),
                    TextFieldContainer(
                      textController: descriptionController,
                      hintText: 'Descriptiion',
                    ),
                    const SpaceSizedBox(),
                    TextFieldContainer(
                      textController: expTimeController,
                      hintText: 'Expected Task Duration in Hours',
                      keyboard: TextInputType.number,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final selectedDateTemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                        );
                        if (selectedDateTemp == null) {
                          return;
                        } else {
                          _dueDateNotifier.value = selectedDateTemp;
                        }
                      },
                      icon: const Icon(Icons.date_range_rounded),
                      label: ValueListenableBuilder(
                          valueListenable: _dueDateNotifier,
                          builder: (context, dueTime, _) {
                            return Text(
                              dueTime == null
                                  ? 'Select Due Date'
                                  : DateFormat.yMMMd().format(dueTime),
                            );
                          }),
                    ),
                    ValueListenableBuilder(
                        valueListenable: _isTaskCompletedNotifier,
                        builder: (context, isTaskCompleted, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Is Task Completed?',
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () {
                                  _isTaskCompletedNotifier.value = true;
                                },
                                icon: Icon(
                                  Icons.task_alt,
                                  color: isTaskCompleted == true
                                      ? Colors.green
                                      : kBlackColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _isTaskCompletedNotifier.value = false;
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: isTaskCompleted == false
                                      ? Colors.red
                                      : kBlackColor,
                                ),
                              ),
                            ],
                          );
                        }),
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
    );
  }

  void addStudent() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final expTime = expTimeController.text.trim();
    if (title.isEmpty) {
      return;
    }
    if (description.isEmpty) {
      return;
    }
    if (expTime.isEmpty) {
      return;
    }
  }

  void editStudent(docId) {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final expTime = expTimeController.text.trim();
    if (title.isEmpty) {
      return;
    }
    if (description.isEmpty) {
      return;
    }
    if (expTime.isEmpty) {
      return;
    }
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.textController,
    required this.hintText,
    this.keyboard = TextInputType.text,
  });

  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboard;

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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Details';
          }
          return null;
        },
        keyboardType: keyboard,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tast_management_app/models/task_model.dart';
import 'package:tast_management_app/services/tasks_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/view/common/space_sizedbox.dart';
import 'package:intl/intl.dart';

class AddUpdateTask extends StatefulWidget {
  const AddUpdateTask({super.key, this.taskData, this.id});

  final String? id;
  final TaskModel? taskData;

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
    titleController = TextEditingController(
      text: widget.taskData?.title ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.taskData?.description ?? '',
    );
    expTimeController = TextEditingController(
      text: widget.taskData?.expTaskDuration ?? '',
    );
    DateTime? dueDate;
    if (widget.taskData?.dueDate != null) {
      dueDate = DateFormat('MMM d, yyyy h:mm a').parse(
        widget.taskData!.dueDate,
      );
    }
    _dueDateNotifier = ValueNotifier<DateTime?>(
      dueDate,
    );
    _isTaskCompletedNotifier = ValueNotifier<bool>(
      widget.taskData?.completionStatus ?? false,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    expTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _dueDateNotifier.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (selectedDate == null) {
      return;
    }

    if (context.mounted) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_dueDateNotifier.value ?? DateTime.now()),
      );
      if (selectedTime == null) {
        return;
      }

      final DateTime combinedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      _dueDateNotifier.value = combinedDateTime;
    }
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
                        _selectDueDate(context);
                      },
                      icon: const Icon(Icons.date_range_rounded),
                      label: ValueListenableBuilder(
                          valueListenable: _dueDateNotifier,
                          builder: (context, dueTime, _) {
                            return Text(
                              dueTime == null
                                  ? 'Select Due Date'
                                  : DateFormat('MMM d, yyyy h:mm a')
                                      .format(dueTime),
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
                                      ? kGreenColor
                                      : kGreyColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _isTaskCompletedNotifier.value = false;
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: isTaskCompleted == false
                                      ? kRedColor
                                      : kGreyColor,
                                ),
                              ),
                            ],
                          );
                        }),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.taskData == null
                              ? addStudent(context)
                              : editStudent(widget.id);
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

  void addStudent(BuildContext context) {
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
    final task = TaskModel(
      title: title,
      description: description,
      dueDate: DateFormat('MMM d, yyyy h:mm a').format(
        _dueDateNotifier.value!,
      ),
      completionStatus: _isTaskCompletedNotifier.value!,
      expTaskDuration: expTime,
    );
    taskService.addTask(task);
    Navigator.pop(context);
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
    final task = TaskModel(
      title: title,
      description: description,
      dueDate: DateFormat('MMM d, yyyy h:mm a').format(
        _dueDateNotifier.value!,
      ),
      completionStatus: _isTaskCompletedNotifier.value!,
      expTaskDuration: expTime,
    );
    taskService.updateTask(docId, task);
    Navigator.pop(context);
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

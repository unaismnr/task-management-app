import 'package:flutter/material.dart';
import 'package:tast_management_app/models/task_model.dart';
import 'package:tast_management_app/services/tasks_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/view/tasks/add_update_task.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final _tasks = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: StreamBuilder(
            stream: _tasks.readTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kMainColor,
                  ),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kMainColor,
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Data'),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Something Error'),
                );
              } else if (snapshot.hasData) {
                return ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final taskData = snapshot.data![index];
                    return Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
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
                      child: ListTile(
                        title: Text(
                          taskData.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskData.description,
                              style: const TextStyle(
                                color: kGreyColor,
                              ),
                            ),
                            Text(
                              'Due Date: ${taskData.dueDate}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Exp Time: ${taskData.expTaskDuration} Hours',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Is Task Completed?',
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Icon(
                                  Icons.task_alt,
                                  color: taskData.completionStatus == true
                                      ? kGreenColor
                                      : kGreyColor,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Icon(
                                  Icons.cancel_outlined,
                                  color: taskData.completionStatus == false
                                      ? kRedColor
                                      : kGreyColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            customBottomSheet(context, taskData.id!, taskData);
                          },
                          icon: const Icon(
                            Icons.more_vert,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: kMainColor,
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: kMainColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddUpdateTask(),
            ),
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add, size: 35),
      ),
    );
  }

  Future<dynamic> customBottomSheet(
    BuildContext context,
    String docId,
    TaskModel taskData,
  ) {
    return showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height / 3.7,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ListTile(
                    leading: taskData.completionStatus
                        ? const Icon(
                            Icons.cancel_outlined,
                          )
                        : const Icon(
                            Icons.task_alt,
                          ),
                    title: Text(
                      taskData.completionStatus
                          ? 'Marked as Not Completed'
                          : 'Marked as Completed',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _tasks.updateTaskStatus(
                        docId,
                        taskData.completionStatus ? false : true,
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.edit,
                    ),
                    title: const Text(
                      'Edit Task',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddUpdateTask(
                            id: docId,
                            taskData: taskData,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.delete,
                    ),
                    title: const Text(
                      'Delete Task',
                    ),
                    onTap: () {
                      _tasks.deleteTask(docId);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
  }
}

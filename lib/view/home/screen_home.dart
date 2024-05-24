import 'package:flutter/material.dart';
import 'package:tast_management_app/services/tasks_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';

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
              } else if (snapshot.data!.docs.isEmpty) {
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
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final taskData = snapshot.data!.docs[index];
                    return Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                        bottom: 5,
                      ),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  taskData['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Text(
                                'Due: ${taskData['deadline']}',
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(taskData['description']),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.task_alt,
                                      color:
                                          taskData['completionStatus'] == true
                                              ? Colors.green
                                              : Colors.grey,
                                    ),
                                    tooltip:
                                        taskData['completionStatus'] == true
                                            ? 'Task Completed'
                                            : 'Task Not Completed',
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit_note_rounded),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
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
    );
  }
}

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
        elevation: 0,
        title: const Text('TASKS'),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final taskData = snapshot.data!.docs[index];
                    return Container(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 233, 241, 255),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(taskData['title']),
                              ),
                              Text(taskData['deadline']),
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
                                    icon: const Icon(Icons.task_alt),
                                    tooltip: 'Tasks Completion Status',
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_vert),
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

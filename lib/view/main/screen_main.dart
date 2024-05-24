import 'package:flutter/material.dart';
import 'package:tast_management_app/view/main/bottom_navigation.dart';
import 'package:tast_management_app/view/home/screen_home.dart';
import 'package:tast_management_app/view/settings/screen_settings.dart';
import 'package:tast_management_app/view/tasks/add_update_task.dart';

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});

  final _pagesList = [
    ScreenHome(),
    const AddUpdateTask(),
    ScreenSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (context, newIndex, _) {
            return _pagesList[newIndex];
          }),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

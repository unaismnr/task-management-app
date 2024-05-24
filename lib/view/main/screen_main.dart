import 'package:flutter/material.dart';
import 'package:tast_management_app/view/main/bottom_navigation.dart';
import 'package:tast_management_app/view/home/screen_home.dart';
import 'package:tast_management_app/view/settings/screen_settings.dart';

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});

  final _pagesList = [
    ScreenHome(),
    const ScreenSettings(),
    const ScreenSettings(),
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

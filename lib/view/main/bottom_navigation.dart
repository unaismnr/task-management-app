import 'package:flutter/material.dart';
import 'package:tast_management_app/utils/color_consts.dart';

ValueNotifier selectedIndexNotifier = ValueNotifier(0);

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (context, newIndex, _) {
          return NavigationBar(
            selectedIndex: newIndex,
            onDestinationSelected: (value) =>
                selectedIndexNotifier.value = value,
            backgroundColor: kWhiteColor,
            indicatorColor: kCardColor.withOpacity(0.8),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.cancel),
                label: 'Task',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          );
        });
  }
}

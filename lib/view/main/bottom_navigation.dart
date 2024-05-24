import 'package:flutter/material.dart';

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
            backgroundColor: Colors.blueAccent[50],
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.task_alt),
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

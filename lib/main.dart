import 'package:flutter/material.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/view/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kMainColor,
        ),
        useMaterial3: false,
      ),
      home: const ScreenHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

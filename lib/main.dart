import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/view/screen_home.dart';

import 'view/login_and_registration/screen_registration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        textTheme: GoogleFonts.latoTextTheme(),
        useMaterial3: false,
      ),
      home: ScreenRegistration(),
      debugShowCheckedModeBanner: false,
    );
  }
}

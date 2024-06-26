import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tast_management_app/services/notification_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tast_management_app/view/login_and_registration/screen_login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.init();
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
      home: ScreenLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}

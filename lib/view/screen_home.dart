import 'package:flutter/material.dart';
import 'package:tast_management_app/services/auth_service.dart';
import 'package:tast_management_app/view/login_and_registration/screen_login.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () {
            _auth.signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ScreenLogin(),
              ),
            );
          },
          child: const Text(
            'SignOut',
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tast_management_app/services/auth_service.dart';
import 'package:tast_management_app/view/login_and_registration/screen_login.dart';

class ScreenSettings extends StatelessWidget {
  ScreenSettings({super.key});

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: TextButton.icon(
          onPressed: () {
            _auth.signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ScreenLogin(),
              ),
            );
          },
          icon: const Icon(Icons.power_settings_new),
          label: const Text('Sign Out'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tast_management_app/services/auth_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/view/common/space_sizedbox.dart';
import 'package:tast_management_app/view/login_and_registration/screen_registration.dart';
import 'package:tast_management_app/view/home/screen_home.dart';

import 'widgets/bottom_text_widget.dart';
import 'widgets/elevated_button_widget.dart';
import 'widgets/text_field_widget.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _auth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: kMainColor,
                    ),
                  ),
                  const Text(
                    "Enter Login Details",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SpaceSizedBox(),
                  TextFieldWidget(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        final emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailValid.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      }),
                  const SpaceSizedBox(),
                  TextFieldWidget(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SpaceSizedBox(),
                  ElevatedButtonWidget(
                    text: "LOGIN",
                    onpressed: () {
                      if (_formKey.currentState!.validate()) {
                        addLog();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ScreenHome(),
                          ),
                        );
                      }
                    },
                  ),
                  const SpaceSizedBox(),
                  BottomTextWidget(
                    accountConfirmText: "Don't you have an account?",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenRegistration(),
                        ),
                      );
                    },
                    loginRegisterText: "Register",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addLog() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (email.isEmpty) {
      return;
    }
    if (password.isEmpty) {
      return;
    }
    await _auth.loginUserWithEmailAndPassword(email, password);
  }
}

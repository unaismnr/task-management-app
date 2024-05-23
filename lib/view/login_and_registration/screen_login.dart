import 'package:flutter/material.dart';
import 'package:tast_management_app/utils/color_consts.dart';

import 'widgets/bottom_text_widget.dart';
import 'widgets/elevated_button_widget.dart';
import 'widgets/text_field_widget.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(
      height: MediaQuery.of(context).size.height * .02,
    );
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
                  space,
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
                  space,
                  TextFieldWidget(
                    controller: _passwordController,
                    hintText: 'Password',
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
                  space,
                  ElevatedButtonWidget(
                    text: "LOGIN",
                    onpressed: () {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                  space,
                  BottomTextWidget(
                    accountConfirmText: "Don't you have an account?",
                    onTap: () {},
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
}
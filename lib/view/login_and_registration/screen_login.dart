import 'package:flutter/material.dart';
import 'package:tast_management_app/services/auth_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/view/common/space_sizedbox.dart';
import 'package:tast_management_app/view/login_and_registration/screen_registration.dart';
import 'package:tast_management_app/view/main/screen_main.dart';

import 'widgets/bottom_text_widget.dart';
import 'widgets/elevated_button_widget.dart';
import 'widgets/text_field_widget.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _auth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final errorMessage = ValueNotifier<String>('');
  final isLoading = ValueNotifier<bool>(false);

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
                  ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, loading, _) {
                        return loading
                            ? const CircularProgressIndicator()
                            : ElevatedButtonWidget(
                                text: "LOGIN",
                                onpressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    addLog(context);
                                  }
                                },
                              );
                      }),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: errorMessage,
                    builder: (context, error, _) {
                      return Text(
                        error,
                        style: const TextStyle(color: kRedColor),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addLog(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (email.isEmpty) {
      return;
    }
    if (password.isEmpty) {
      return;
    }
    isLoading.value = true;
    try {
      errorMessage.value = '';
      await _auth.loginUserWithEmailAndPassword(email, password);
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ScreenMain(),
            ),
            (route) => false);
      }
    } catch (e) {
      errorMessage.value = 'Wrong login details';
    } finally {
      isLoading.value = false;
    }
  }
}

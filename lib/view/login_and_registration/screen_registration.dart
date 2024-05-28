import 'package:flutter/material.dart';
import 'package:tast_management_app/services/auth_service.dart';
import 'package:tast_management_app/utils/color_consts.dart';
import 'package:tast_management_app/view/common/space_sizedbox.dart';
import 'package:tast_management_app/view/login_and_registration/screen_login.dart';
import 'package:tast_management_app/view/main/screen_main.dart';
import 'widgets/bottom_text_widget.dart';
import 'widgets/elevated_button_widget.dart';
import 'widgets/text_field_widget.dart';

class ScreenRegistration extends StatelessWidget {
  ScreenRegistration({super.key});

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
                    "Account Creation",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: kMainColor,
                    ),
                  ),
                  const Text(
                    "Enter Your Details",
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
                    },
                  ),
                  const SpaceSizedBox(),
                  TextFieldWidget(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SpaceSizedBox(),
                  ValueListenableBuilder<bool>(
                    valueListenable: isLoading,
                    builder: (context, loading, _) {
                      return loading
                          ? const CircularProgressIndicator()
                          : ElevatedButtonWidget(
                              text: "SUBMIT",
                              onpressed: () {
                                if (_formKey.currentState!.validate()) {
                                  addReg(context);
                                }
                              },
                            );
                    },
                  ),
                  const SpaceSizedBox(),
                  BottomTextWidget(
                    accountConfirmText: "Do you already have an account?",
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => ScreenMain(),
                        ),
                        (route) => false,
                      );
                    },
                    loginRegisterText: "Login",
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

  void addReg(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Email and password cannot be empty.';
      return;
    }

    isLoading.value = true;

    try {
      errorMessage.value = '';
      final isRegistered = await _auth.isEmailRegistered(
        email,
        password,
      );

      if (isRegistered) {
        errorMessage.value = 'Email is already registered.';
      } else {
        await _auth.createUserWithEmailAndPassword(email, password);
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ScreenLogin()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}

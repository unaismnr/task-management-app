import 'package:flutter/material.dart';
import 'package:tast_management_app/utils/color_consts.dart';

class BottomTextWidget extends StatelessWidget {
  final String accountConfirmText;
  final void Function() onTap;
  final String loginRegisterText;

  const BottomTextWidget({
    super.key,
    required this.accountConfirmText,
    required this.onTap,
    required this.loginRegisterText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(accountConfirmText),
        SizedBox(
          width: MediaQuery.of(context).size.width * .015,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            loginRegisterText,
            style: const TextStyle(
              color: kMainColor,
            ),
          ),
        )
      ],
    );
  }
}

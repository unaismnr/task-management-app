import 'package:flutter/material.dart';
import 'package:tast_management_app/utils/color_consts.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final void Function() onpressed;

  const ElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .06,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: kMainColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: kWhiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

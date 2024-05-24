import 'package:flutter/material.dart';

class SpaceSizedBox extends StatelessWidget {
  const SpaceSizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .017,
    );
  }
}

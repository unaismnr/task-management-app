import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}

// TextButton(
//           onPressed: () {
//             _auth.signOut();
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => ScreenLogin(),
//               ),
//             );
//           },
//           child: const Text(
//             'SignOut',
//           ),
//         ),
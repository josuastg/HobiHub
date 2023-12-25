import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/screens/login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Started Screen'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => _dialogBuilder(context),
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const LoginScreen()),
            // );

            child: const Text('Go To Login Screen')),
      ),
    );
  }
}

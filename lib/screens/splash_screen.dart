import 'package:flutter/material.dart';
import 'package:hobihub/screens/get_started_screen.dart';
import 'package:hobihub/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Screen'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GetStartedScreen()),
              );
            },
            child: const Text('Go To Home Screen')),
      ),
    );
  }
}

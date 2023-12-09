import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Started Screen'),
      ),
      body: const Center(
        child: Text('This is Get Started Screen'),
      ),
    );
  }
}

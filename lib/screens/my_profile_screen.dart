import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile Screen'),
      ),
      body: const Center(
        child: Text('This is My Profile Screen'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Screen'),
      ),
      body: const Center(
        child: Text('This is Edit Profile Screen'),
      ),
    );
  }
}

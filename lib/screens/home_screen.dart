import 'package:flutter/material.dart';
import 'package:hobihub/screens/my_profile_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child:  ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfileScreen()));
        }, 
        child: const Text("Go to My Profile Screen"),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hobihub/screens/login_screen.dart';

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
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        }, 
        child: const Text("Go to Login Screen"),
        ),
      ),
    );
  }
}

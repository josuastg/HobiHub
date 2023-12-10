import 'package:flutter/material.dart';
import 'package:hobihub/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
        }, 
        child: const Text("Go to Register Screen")),
      ),
    );
  }
}

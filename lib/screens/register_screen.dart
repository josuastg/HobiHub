import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Screen"),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/images/Shape.svg"
            ),
            const SizedBox(
              height: 1,
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Welcome Onboard!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 181, 93, 190),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text(
                    "Let’s help you connect with your hobby.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 181, 93, 190),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  SvgPicture.asset(
                    "assets/images/Vector.svg",
                    width: 88,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

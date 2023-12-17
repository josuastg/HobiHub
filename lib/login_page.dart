import 'package:flutter/material.dart';
import 'package:hobihub_login/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    setState(() {
      if (emailController.text.isEmpty) {
        emailError = 'Email must be filled with characters!';
      } else {
        emailError = null;
      }

      if (passwordController.text.isEmpty) {
        passwordError = 'Password must be filled with characters!';
      } else {
        passwordError = null;
      }
    });

    if (emailError == null && passwordError == null) {
      // Perform your login logic here
      // For example, you can show a snackbar or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged in successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 25,
            top: 500,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: emailController,
                    style: purpleTextStyle.copyWith(fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'Enter Your Email',
                      errorText: emailError,
                      labelStyle: purpleTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 3,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    style: purpleTextStyle.copyWith(fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      errorText: passwordError,
                      labelStyle: purpleTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 3,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 3,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.purple, // Ubah warna ikon menjadi ungu
                        ),
                      ),
                    ),
                    obscureText: !isPasswordVisible,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            left: 130,
            top: 185,
            child: Text(
              'Welcome Back!',
              style: purpleTextStyle.copyWith(fontSize: 19),
            ),
          ),
          Positioned(
            left: 60,
            top: 200,
            child: Image.asset(
              'assets/login_image.png',
              width: 285,
              height: 285,
            ),
          ),
          Positioned(
            left: -30,
            top: -30,
            child: Image.asset(
              'assets/shape_login_image.png',
              width: 290,
              height: 268,
            ),
          ),
          Positioned(
            left: 40,
            top: 685,
            child: ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Container(
                width: 310,
                height: 55,
                alignment: Alignment.center,
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 90,
            top: 735,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have any account? ",
                  style: purpleTextStyle.copyWith(
                    color: Colors.purple,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add navigation to sign up page
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Sign Up?',
                    style: purpleTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

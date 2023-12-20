import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/screens/register_screen.dart';

TextStyle purpleTextStyle = const TextStyle(
  color: Color.fromARGB(255, 181, 93, 190),
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  final _formKey = GlobalKey<FormState>();

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged in successfully!'),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 10),
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/images/Shape.svg"),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Color.fromARGB(255, 181, 93, 190),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Center(
                        child:
                            SvgPicture.asset('assets/images/login_image.svg'),
                      ),
                      const SizedBox(
                        height: 56,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              // style: purpleTextStyle.copyWith(fontSize: 12),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                border: const UnderlineInputBorder(),
                                labelText: 'Enter Your Email',
                                errorText: emailError,
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(
                                  255,
                                  181,
                                  93,
                                  190,
                                )),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 93, 190),
                                    width: 3,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 93, 190),
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 38,
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                labelText: 'Enter Password',
                                errorText: passwordError,
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(
                                  255,
                                  181,
                                  93,
                                  190,
                                )),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 93, 190),
                                    width: 3,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 93, 190),
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
                                    color:
                                        const Color.fromARGB(255, 181, 93, 190),
                                  ),
                                ),
                              ),
                              obscureText: !isPasswordVisible,
                            ),
                            const SizedBox(
                              height: 65,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: signIn,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 181, 93, 190),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have any account? ",
                                  style: purpleTextStyle.copyWith(
                                    color:
                                        const Color.fromARGB(255, 181, 93, 190),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen()),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(0, 255, 255, 255),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: purpleTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

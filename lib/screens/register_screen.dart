import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/main.dart';
import 'package:hobihub/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _fullName = false;
  bool _passwordMatch = true;
  bool _passwordError = false;
  bool _emailError = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool _isButtonDisabled() {
    return _fullNameController.text.isEmpty ||
    _emailController.text.isEmpty ||
    _passwordController.text.isEmpty ||
    _confirmPasswordController.text.isEmpty ||
    _passwordController.text != _confirmPasswordController.text;
  }

  final _formKey = GlobalKey<FormState>();

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
              SvgPicture.asset(
                "assets/images/Shape.svg"
              ),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
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
                      // SvgPicture.asset(
                      //   "assets/images/Vector.svg",
                      //   width: 88,
                      // ),
                      const SizedBox(
                        height: 33,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _fullNameController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                border: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 181, 93, 190),
                                  ),
                                ),
                                labelText: 'Enter Your Full Name',
                                labelStyle: const TextStyle(color: Color.fromARGB(255, 181, 93, 190,)),
                                errorText: _fullName ? "Full Name must be filled" : null,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _fullName = (value == null || value.isEmpty);
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                border: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:  BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 181, 93, 190),
                                  ),
                                ),
                                labelText: 'Enter Your Email',
                                labelStyle: const TextStyle(color: Color.fromARGB(255, 181, 93, 190,)),
                                errorText: _emailError ? "Email must be filled with the characters!" : null,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _emailError = (value == null || value.isEmpty);
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                border: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 181, 93, 190),
                                  ),
                                ),
                                labelText: 'Enter Your Password',
                                labelStyle: const TextStyle(color: Color.fromARGB(255, 181, 93, 190,)),
                                errorText: _passwordError ? "Password min 8 character!" : null,
                                suffixIcon: IconButton(onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                }, icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,
                                color: const Color.fromARGB(255, 181, 93, 190),
                                )),
                              ),
                              obscureText: _passwordVisible,

                              onChanged: (value) {
                                setState(() {
                                  _passwordError = (value.length < 8 || value == null);
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                border: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 181, 93, 190),
                                  ),
                                ),
                                suffixIcon: IconButton(onPressed: () {
                                  setState(() {
                                    _confirmPasswordVisible = !_confirmPasswordVisible;
                                  });
                                }, icon: Icon(_confirmPasswordVisible ? Icons.visibility_off : Icons.visibility, 
                                color: const Color.fromARGB(255, 181, 93, 190),
                                )),
                                labelText: 'Confirm Password',
                                labelStyle: const TextStyle(color: Color.fromARGB(255, 181, 93, 190)),
                                errorText: _passwordMatch ? null : "password confirmation not match to password!" ,
                              ),
                              obscureText: _confirmPasswordVisible,

                              onChanged: (value) {
                                setState(() {
                                  _passwordMatch = _passwordController.text == _confirmPasswordController.text;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 59,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 181, 93, 190),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                                onPressed: _isButtonDisabled() ? null : () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully Register User!"),
                                    backgroundColor: Colors.green,
                                    ));
                                  }
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                              }, 
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),)),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            RichText(text: TextSpan(
                              text: "Already have an account?",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 181, 93, 190),
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Sign In",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 181, 93, 190),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                  }
                                )
                              ]
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

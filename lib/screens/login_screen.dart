import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/global/const/page_const.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:hobihub/user/presentation/cubit/credential/credential_cubit.dart';

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

  bool isEmailValid = true;
  bool isPasswordValid = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(validateEmail);
    passwordController.addListener(validatePassword);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateEmail() {
    setState(() {
      if (emailController.text.isEmpty) {
        isEmailValid = true;
      } else {
        isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(emailController.text);
      }
    });
    return;
  }

  void validatePassword() {
    setState(() {
      if (passwordController.text.isEmpty) {
        isPasswordValid = true;
      } else {
        isPasswordValid = passwordController.text.length >= 8;
      }
    });
    return;
  }

  void signIn() {
    validateEmail();
    validatePassword();
    BlocProvider.of<CredentialCubit>(context).signInSubmit(
        email: emailController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        isEmailValid &&
        isPasswordValid;

    return Scaffold(
        body: BlocConsumer<CredentialCubit, CredentialState>(
      builder: (context, credentialState) {
        if (credentialState is CredentialLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              } else {
                return _bodyWidget(isButtonEnabled);
              }
            },
          );
        }
        return _bodyWidget(isButtonEnabled);
      },
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logged in successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (credentialState is CredentialFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong Email or Password!'),
              backgroundColor: Colors.red,
            ),
          );
          //toast
          //alertDialog
          ///SnackBar
        }
      },
    ));
  }

  Widget _bodyWidget(bool isButtonEnabled) {
    return SingleChildScrollView(
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
                      child: SvgPicture.asset('assets/images/login_image.svg'),
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            onChanged: (value) {
                              validateEmail();
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              border: const UnderlineInputBorder(),
                              labelText: 'Enter Your Email',
                              errorText: isEmailValid
                                  ? null
                                  : 'Email you entered is incorrect!',
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
                            onChanged: (value) {
                              validatePassword();
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              labelText: 'Enter Password',
                              errorText: isPasswordValid
                                  ? null
                                  : 'Password must be at least 8 characters!',
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
                              onPressed: isButtonEnabled ? signIn : null,
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
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      PageConst.registrationPage,
                                      (routes) => false);
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
    );
  }
}

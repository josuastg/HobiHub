import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/screens/login_screen.dart';
import 'package:hobihub/storage/domain/usecases/upload_profile_image_usecase.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';
import 'package:hobihub/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:hobihub/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hobihub/injection_container.dart' as di;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File? _imageFile;
  bool _fullName = false;
  bool _passwordMatch = true;
  bool _passwordError = false;
  bool _emailError = false;
  String _errorMessage = "";
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool _isButtonDisabled() {
    return _fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _emailError ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _passwordController.text != _confirmPasswordController.text ||
        _imageFile == null ||
        _imageFile!.path.isEmpty;
  }

  final _formKey = GlobalKey<FormState>();

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _emailError = true;
        _errorMessage = "Email must be filled with the characters!";
      });
    } else if (!EmailValidator.validate(val)) {
      setState(() {
        _emailError = true;
        _errorMessage = "Email you entered is incorrect!";
      });
    } else {
      setState(() {
        _emailError = false;
        _errorMessage = "";
      });
    }
  }

  void setValidMatchPassword() {
    setState(() {
      _passwordMatch =
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  void setInvalidPassword(String value) {
    setState(() {
      _passwordError = (value.length < 8 || value.isEmpty);
    });
    setValidMatchPassword();
  }

  void setValidName(String value) {
    setState(() {
      _fullName = value.isEmpty;
    });
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take a Photo'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  void submitSignUp() {
    if (_imageFile != null) {
      di
          .sl<UploadProfileImageUseCase>()
          .call(file: _imageFile!)
          .then((imageUrl) {
        BlocProvider.of<CredentialCubit>(context)
            .signUpSubmit(
                user: UserEntity(
                    fullName: _fullNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    imgUrl: imageUrl))
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register Profile Successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        });
      });
    }
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {
        _showImagePickerOptions();
      },
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        backgroundImage: _imageFile != null && _imageFile!.path.isNotEmpty
            ? FileImage(File(_imageFile!.path)) as ImageProvider<Object>
            : null,
        child: _imageFile == null ||
                (_imageFile != null && _imageFile!.path.isEmpty)
            ? SvgPicture.asset(
                'assets/images/Vector.svg',
                width: 100,
                height: 100,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 181, 93, 190)),
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
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
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
      ),
    );
  }

  Widget _bodyWidget() {
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
                    _buildProfileImage(),
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
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              border: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 181, 93, 190),
                                ),
                              ),
                              labelText: 'Enter Your Full Name',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(
                                255,
                                181,
                                93,
                                190,
                              )),
                              errorText:
                                  _fullName ? "Full Name must be filled" : null,
                            ),
                            onChanged: (value) => setValidName(value),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              border: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 181, 93, 190),
                                ),
                              ),
                              labelText: 'Enter Your Email',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(
                                255,
                                181,
                                93,
                                190,
                              )),
                              errorText: _emailError ? _errorMessage : null,
                            ),
                            onChanged: (value) => validateEmail(value),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              border: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 181, 93, 190),
                                ),
                              ),
                              labelText: 'Enter Your Password',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(
                                255,
                                181,
                                93,
                                190,
                              )),
                              errorText: _passwordError
                                  ? "Password min 8 character!"
                                  : null,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color:
                                        const Color.fromARGB(255, 181, 93, 190),
                                  )),
                            ),
                            obscureText: _passwordVisible,
                            onChanged: (value) => setInvalidPassword(value),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              border: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 181, 93, 190),
                                ),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _confirmPasswordVisible =
                                          !_confirmPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _confirmPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color:
                                        const Color.fromARGB(255, 181, 93, 190),
                                  )),
                              labelText: 'Confirm Password',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 181, 93, 190)),
                              errorText: _passwordMatch
                                  ? null
                                  : "Password confirmation not match to password!",
                            ),
                            obscureText: _confirmPasswordVisible,
                            onChanged: (value) => setValidMatchPassword(),
                          ),
                          const SizedBox(
                            height: 59,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 181, 93, 190),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed:
                                    _isButtonDisabled() ? null : submitSignUp,
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "Already have an account?",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 181, 93, 190),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: "Sign In",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 181, 93, 190),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      })
                              ]))
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
    );
  }
}

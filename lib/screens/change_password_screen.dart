import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hobihub/screens/my_profile_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordMatch = true;
  bool _passwordError = false;
  String _errorMessage = "";
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool _isButtonDisabled() {
    return _currentPasswordController.text.isEmpty ||
        _passwordError ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _newPasswordController.text != _confirmPasswordController.text ||
        _currentPasswordController.text == _newPasswordController.text;
  }

  final _formKey = GlobalKey<FormState>();

  void setValidMatchPassword() {
    setState(() {
      _passwordMatch =
          _newPasswordController.text == _confirmPasswordController.text;
    });
  }

  void setInvalidPassword(String value) {
    setState(() {
      _passwordError = (value.length < 8 || value.isEmpty);
    });
    setValidMatchPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 181, 93, 190),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyProfileScreen()),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _currentPasswordController,
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
                        labelText: 'Current Password',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(
                          255,
                          181,
                          93,
                          190,
                        )),
                        errorText:
                            _passwordError ? "Password min 8 character!" : null,
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
                              color: const Color.fromARGB(255, 181, 93, 190),
                            )),
                      ),
                      obscureText: _passwordVisible,
                      onChanged: (value) => setInvalidPassword(value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _newPasswordController,
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
                        labelText: 'New Password',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(
                          255,
                          181,
                          93,
                          190,
                        )),
                        errorText:
                            _passwordError ? "Password min 8 character!" : null,
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
                              color: const Color.fromARGB(255, 181, 93, 190),
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
                              color: const Color.fromARGB(255, 181, 93, 190),
                            )),
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 181, 93, 190)),
                        errorText: _passwordMatch
                            ? null
                            : "Password confirmation not match to new password!",
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
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: _isButtonDisabled()
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Successfully Change Password !"),
                                      backgroundColor: Colors.green,
                                    ));
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyProfileScreen()));
                                },
                          child: const Text(
                            "Change Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

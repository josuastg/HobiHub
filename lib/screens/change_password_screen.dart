import 'package:flutter/material.dart';
import 'package:hobihub/global/const/page_const.dart';
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
  bool _currentpasswordError = false;
  bool _newpasswordError = false;
  bool _currentpasswordVisible = false;
  bool _newpasswordVisible = false;
  bool _confirmPasswordVisible = false;

  bool _isButtonDisabled() {
    return _currentPasswordController.text.isEmpty ||
        _currentpasswordError ||
        _newpasswordError ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _newPasswordController.text != _confirmPasswordController.text;
  }

  final _formKey = GlobalKey<FormState>();

  void setValidMatchPassword() {
    setState(() {
      _passwordMatch =
          _newPasswordController.text == _confirmPasswordController.text;
    });
  }

  void setInvalidCurrentPassword(String value) {
    setState(() {
      _currentpasswordError = (value.length < 8 || value.isEmpty);
    });
  }

  void setInvalidNewPassword(String value) {
    setState(() {
      _newpasswordError = (value.length < 8 || value.isEmpty);
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
            onPressed: () =>
                Navigator.pushNamed(context, PageConst.myProfilePage),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 10),
          child: Padding(
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
                            errorText: _currentpasswordError
                                ? "Password min 8 character!"
                                : null,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _currentpasswordVisible =
                                        !_currentpasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _currentpasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color:
                                      const Color.fromARGB(255, 181, 93, 190),
                                )),
                          ),
                          obscureText: _currentpasswordVisible,
                          onChanged: (value) =>
                              setInvalidCurrentPassword(value),
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
                            errorText: _newpasswordError
                                ? "Password min 8 character!"
                                : null,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _newpasswordVisible = !_newpasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _newpasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color:
                                      const Color.fromARGB(255, 181, 93, 190),
                                )),
                          ),
                          obscureText: _newpasswordVisible,
                          onChanged: (value) => setInvalidNewPassword(value),
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
                                : "Password confirmation not match to new password!",
                          ),
                          obscureText: _confirmPasswordVisible,
                          onChanged: (value) => setValidMatchPassword(),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
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
                                  fontSize: 18,
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
        ));
  }
}

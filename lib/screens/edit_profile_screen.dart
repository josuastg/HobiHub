import 'package:flutter/material.dart';
import 'package:hobihub/global/const/page_const.dart';
import 'package:hobihub/screens/my_profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noTlpController = TextEditingController();

  bool _name = false;
  bool _email = false;
  bool _noTlp = false;

  bool _isButtonDisabled() {
    return _nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _noTlpController.text.isEmpty;
  }

  final _formKey = GlobalKey<FormState>();

  void setValidName(String value) {
    setState(() {
      _name = value.isEmpty;
    });
  }

  void setValidEmail(String value) {
    setState(() {
      _email = value.isEmpty;
    });
  }

  void setValidNoTlp(String value) {
    setState(() {
      _noTlp = value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
              iconSize: 30,
            ),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22),
            ),
            backgroundColor: const Color.fromARGB(255, 181, 93, 190)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 93, 190),
                                    width: 3)),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 181, 93, 190))),
                        onChanged: (value) => setValidName(value),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 93, 190),
                                    width: 3)),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 181, 93, 190))),
                        onChanged: (value) => setValidEmail(value),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 93, 190),
                                    width: 3)),
                            labelText: 'No.Tlp',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 181, 93, 190))),
                        onChanged: (value) => setValidNoTlp(value),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 310,
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 181, 93, 190),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _isButtonDisabled()
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("Successfully Update Profile !"),
                                    backgroundColor: Colors.green,
                                  ));
                                }
                                Navigator.pushNamed(
                                    context, PageConst.myProfilePage);
                              },
                        child: const Text(
                          'Change Profile',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

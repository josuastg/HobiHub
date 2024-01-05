import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hobihub/screens/my_profile_screen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
              SizedBox(
                height: 150,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 181, 93, 190),
                              width: 3)),
                      labelText: 'Name',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 181, 93, 190))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 181, 93, 190),
                              width: 3)),
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 181, 93, 190))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 181, 93, 190),
                              width: 3)),
                      labelText: 'No.Tlp',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 181, 93, 190))),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 310,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 181, 93, 190),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const MyProfileScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Change Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

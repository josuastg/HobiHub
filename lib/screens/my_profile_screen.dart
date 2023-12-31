import 'package:flutter/material.dart';
import 'package:hobihub/screens/change_password_screen.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  void _openBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => const BottomSheetMenu(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.white,
                iconSize: 40,
                padding: const EdgeInsets.only(top: 1),
                onPressed:()=> _openBottomSheetMenu(context)),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
          ),
          backgroundColor: const Color.fromARGB(255, 181, 93, 190)),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              const Text(
                'Name',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 181, 93, 190),
                    fontSize: 16),
              ),
              const Text(
                'Email@gmail.com',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 181, 93, 190),
                    fontSize: 16),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 300,
                height: 40,
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
                          return const ChangePassword();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 300,
                height: 40,
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
                          return const ChangePassword();
                        },
                      ),
                    );
                  },
                  child: const Text('Change Password',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/screens/my_profile_screen.dart';
import 'package:hobihub/screens/login_screen.dart';

class BottomSheetMenu extends StatefulWidget {
  const BottomSheetMenu({Key? key}) : super(key: key);

  @override
  State<BottomSheetMenu> createState() {
    return _BottomSheetMenuState();
  }
}

class _BottomSheetMenuState extends State<BottomSheetMenu> {
  void _navigateToHome() {
    Navigator.pop(context); // Tutup bottom sheet
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _navigateToMyProfile() {
    Navigator.pop(context); // Tutup bottom sheet
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyProfileScreen()),
    );
  }

  void _logout() {
    Navigator.pop(context); // Tutup bottom sheet
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    Color purpleTextColor =
        const Color.fromARGB(255, 181, 93, 190); // Format ARGB

    return SizedBox(
      height: deviceHeight / 3, // 1/3 dari tinggi layar
      width: deviceWidth, // Lebar layar
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _navigateToHome,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: SvgPicture.asset(
                      'assets/images/icon_home.svg', // Sesuaikan path dengan lokasi ikon Home
                      width: 24,
                      height: 24,
                      color: purpleTextColor,
                    ),
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20,
                      color: purpleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30), // Jarak antara 'Home' dan 'My Profile'
          GestureDetector(
            onTap: _navigateToMyProfile,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: SvgPicture.asset(
                      'assets/images/icon_profile.svg', // Sesuaikan path dengan lokasi ikon Profile
                      width: 24,
                      height: 24,
                      color: purpleTextColor,
                    ),
                  ),
                  Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 20,
                      color: purpleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30), // Jarak antara 'My Profile' dan 'About'
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Tutup bottom sheet
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Info'),
                    content: const Text('Halaman "About" belum tersedia.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 26.0),
                    child: SvgPicture.asset(
                      'assets/images/icon_info.svg', // Sesuaikan path dengan lokasi ikon Info
                      width: 24,
                      height: 24,
                      color: purpleTextColor,
                    ),
                  ),
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      color: purpleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80), // Jarak antara 'About' dan 'Logout'
          GestureDetector(
            onTap: _logout,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 20,
                  color: purpleTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

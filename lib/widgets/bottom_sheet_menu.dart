import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/models/navigation_menu.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/screens/my_profile_screen.dart';
import 'package:hobihub/screens/login_screen.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    Color purpleTextColor = const Color.fromARGB(255, 181, 93, 190);

    List<NavigationMenu> menus = [
      NavigationMenu(icon: 'assets/images/icon_home.svg', title: 'Home'),
      NavigationMenu(
          icon: 'assets/images/icon_profile.svg', title: '  My Profile'),
      NavigationMenu(icon: 'assets/images/icon_info.svg', title: ' About'),
    ];

    return SizedBox(
      height: deviceHeight / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var menu in menus)
            GestureDetector(
              onTap: () {
                if (menu.title == 'Home') {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else if (menu.title == '  My Profile') {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyProfileScreen()),
                  );
                } else if (menu.title == ' About') {
                  // Handle About menu
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
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      menu.icon,
                      width: 24,
                      height: 24,
                      color: purpleTextColor,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      menu.title,
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
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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

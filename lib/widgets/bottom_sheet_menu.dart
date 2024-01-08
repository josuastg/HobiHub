import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobihub/global/const/page_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hobihub/models/navigation_menu.dart';
import 'package:hobihub/user/presentation/cubit/auth/auth_cubit.dart';

class BottomSheetMenu extends StatefulWidget {
  const BottomSheetMenu({super.key});

  @override
  _BottomSheetMenuState createState() => _BottomSheetMenuState();
}

class _BottomSheetMenuState extends State<BottomSheetMenu> {
  Color purpleTextColor = const Color.fromARGB(255, 181, 93, 190);

  void onNavigationMenu(NavigationMenu menu, BuildContext context) {
    Navigator.pop(context);

    if (menu.title == 'Home') {
      Navigator.pushNamed(context, PageConst.homePage);
    } else if (menu.title == '  My Profile') {
      Navigator.pushNamed(context, PageConst.myProfilePage);
    } else {
      Navigator.pushNamed(context, PageConst.infoAppPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

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
              onTap: () => onNavigationMenu(menu, context),
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
            onTap: () => _dialogBuilder(context),
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

  Future _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: (MediaQuery.of(context).size.height / 2) - 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logging_out.png",
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    const Text(
                      'Are you sure you want to log out?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 181, 93, 190),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context); // Tutup bottom sheet
                            Navigator.pop(context); // Tutup bottom sheet
                            BlocProvider.of<AuthCubit>(context).loggedOut();
                            Navigator.pushNamedAndRemoveUntil(
                                context, PageConst.loginPage, (route) => false);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color.fromARGB(255, 181, 93, 190),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'YES',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 181, 93, 190),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Tutup bottom sheet
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 181, 93, 190),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'NO',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

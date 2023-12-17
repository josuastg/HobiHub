import 'package:flutter/material.dart';
import 'package:hobihub/models/hobby.dart';
import 'package:hobihub/screens/my_profile_screen.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';
import 'package:hobihub/widgets/hobby_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  void _openBottomSheetMenu() {
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
        backgroundColor: const Color.fromARGB(255, 181, 93, 190),
        title: const Text(
          'Home Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              HobbyCard(hobby: 
              Hobby(
                imageUrl: "assets/images/Sports.png",
                title: "Sports",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              HobbyCard(hobby: 
              Hobby(
                imageUrl: "assets/images/Music.png", 
                title: "Music"
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              HobbyCard(hobby: 
              Hobby(
                imageUrl: "assets/images/Travel.png", 
                title: "Traveling"
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              HobbyCard(hobby: 
              Hobby(
                imageUrl: "assets/images/Games.png", 
                title:"Games"
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const MyProfileScreen()));
              //     },
              //     child: const Text("Go to My Profile Screen"),
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: _openBottomSheetMenu,
              //   child: const Text("Show Bottom Sheet"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

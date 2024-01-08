import 'package:flutter/material.dart';
import 'package:hobihub/models/hobby.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';
import 'package:hobihub/widgets/hobby_card.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

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

  List<Hobby> hobbies = [
    Hobby(imageUrl: "assets/images/Sports.png", title: "Sports"),
    Hobby(imageUrl: "assets/images/Music.png", title: "Music"),
    Hobby(imageUrl: "assets/images/Travel.png", title: "Traveling"),
    Hobby(imageUrl: "assets/images/Games.png", title: "Games"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              iconSize: 30,
              padding: const EdgeInsets.only(top: 1),
              onPressed: _openBottomSheetMenu,
            )),
        backgroundColor: const Color.fromARGB(255, 181, 93, 190),
        title: const Text(
          'All Group Chat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: hobbies.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                HobbyCard(hobby: hobbies[index]),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

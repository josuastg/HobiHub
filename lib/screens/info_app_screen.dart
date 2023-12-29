import 'package:flutter/material.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';

class InfoApplication extends StatelessWidget {
  const InfoApplication({super.key});

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
            iconSize: 30,
            padding: const EdgeInsets.only(top: 1),
            onPressed: () => _openBottomSheetMenu(context),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 181, 93, 190),
        title: const Text(
          'Info Application',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              Text(
                "HobiHub is a mobile application designed for hobbyist communities with various interests. "
                "It serves as a central platform for sharing knowledge, experiences, and resources related to a wide range of hobbies.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 181, 93, 190),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "The application allows users to join communities that align with their interests, "
                "interact with fellow hobbyists, and access various features specifically designed to support their hobbies.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 181, 93, 190),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

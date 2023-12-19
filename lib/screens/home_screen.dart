import 'package:flutter/material.dart';
import 'package:hobihub/screens/my_profile_screen.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';

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
        title: const Text('Home Screen'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyProfileScreen()));
              },
              child: const Text("Go to My Profile Screen"),
            ),
          ),
          ElevatedButton(
            onPressed: _openBottomSheetMenu,
            child: const Text("Show Bottom Sheet"),
          ),
        ],
      ),
    );
  }
}

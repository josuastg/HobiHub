import 'package:flutter/material.dart';
import 'package:hobihub/models/hobby.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';
import 'package:hobihub/widgets/hobby_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Hobby>> _hobbiesFuture;

  @override
  void initState() {
    super.initState();
    _hobbiesFuture = _fetchHobbies();
  }

  Future<List<Hobby>> _fetchHobbies() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('group').get();

      return snapshot.docs
          .where((doc) =>
              doc.data() != null &&
              doc.data()!['groupProfileImage'] != null &&
              doc.data()!['groupName'] != null)
          .map((doc) => Hobby.fromJson(doc.data()!))
          .toList();
    } catch (error) {
      print('Error fetching hobbies: $error');
      throw error;
    }
  }

  void _openBottomSheetMenu() {
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => const BottomSheetMenu(),
    );
  }

  // List<Hobby> hobbies = [
  //   Hobby(imageUrl: "assets/images/Sports.png", title: "Sports"),
  //   Hobby(imageUrl: "assets/images/Music.png", title: "Music"),
  //   Hobby(imageUrl: "assets/images/Travel.png", title: "Traveling"),
  //   Hobby(imageUrl: "assets/images/Games.png", title: "Games"),
  // ];

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
      body: FutureBuilder<List<Hobby>>(
        future: _hobbiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Error state
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Data available and not empty state
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    HobbyCard(hobby: snapshot.data![index]),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            );
          } else {
            // Empty state
            return Center(
              child: Text("No Group Created Yet"),
            );
          }
        },
      ),
    );
  }
}

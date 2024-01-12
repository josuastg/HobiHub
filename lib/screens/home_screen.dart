import 'package:flutter/material.dart';
import 'package:hobihub/user/domain/entities/hobby_entity.dart';
import 'package:hobihub/user/domain/usercases/get_hobbies_usecase.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';
import 'package:hobihub/widgets/hobby_card.dart';
import 'package:hobihub/user/data/repository/hobby_repository_impl.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<HobbyEntity>> _hobbiesFuture;

  @override
  void initState() {
    super.initState();
    final hobbyRepository = HobbyRepositoryImpl();
    final getHobbiesUsecase = GetHobbiesUsecase(hobbyRepository);
    _hobbiesFuture = getHobbiesUsecase.call();
  }

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
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          iconSize: 30,
          padding: const EdgeInsets.only(top: 1),
          onPressed: _openBottomSheetMenu,
        ),
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
      body: FutureBuilder<List<HobbyEntity>>(
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
                // Menggunakan metode toHobby yang telah didefinisikan
                var hobby = snapshot.data![index].toHobby();
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    HobbyCard(hobby: hobby),
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

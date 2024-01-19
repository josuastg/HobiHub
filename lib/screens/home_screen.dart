import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobihub/group/domain/entities/single_chat_entity.dart';
import 'package:hobihub/group/presentation/cubits/group/group_cubit.dart';
import 'package:hobihub/widgets/bottom_sheet_menu.dart';
import 'package:hobihub/widgets/hobby_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final GroupCubit _groupCubit;

  @override
  void initState() {
    super.initState();
    _groupCubit = context.read<GroupCubit>();
    _groupCubit.getGroups();
    getUser();
  }

  void getUser() {
    final authUser = FirebaseAuth.instance.currentUser;
    print(authUser);
    if(authUser != null) {
      final currentUser = FirebaseFirestore.instance.collection('user').doc(authUser.uid);
      print(currentUser);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _openBottomSheetMenu,
          icon: const Icon(Icons.menu),
          color: Colors.white,
          iconSize: 30,
          padding: const EdgeInsets.only(top: 1),
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
      body: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
          final currentUser = FirebaseAuth.instance.currentUser;

          if (state is GroupLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GroupLoaded) {
            if (state.group.isEmpty) {
              return const Center(child: Text("No Group Created Yet"));
            } else {
              return ListView.builder(
                itemCount: state.group.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      HobbyCard(
                        hobby: state.group[index],
                        singleChatEntity: SingleChatEntity(
                            groupId: state.group[index].uid,
                            groupName: state.group[index].groupName,
                            uid: currentUser!.uid,
                            username: currentUser!.email),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              );
            }
          } else if (state is GroupFailure) {
            return const Center(child: Text("Error fetching groups"));
          } else {
            return const Center(child: Text("Unexpected state"));
          }
        },
      ),
    );
  }
}

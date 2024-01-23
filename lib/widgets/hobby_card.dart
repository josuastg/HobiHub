import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hobihub/group/domain/entities/group_entity.dart';
import 'package:hobihub/group/domain/entities/single_chat_entity.dart';
import 'package:hobihub/widgets/pop_up_join_chat.dart';
import 'package:hobihub/screens/chat_screen.dart';

class HobbyCard extends StatelessWidget {
  final GroupEntity hobby;
  final SingleChatEntity singleChatEntity;

  const HobbyCard({
    Key? key,
    required this.hobby,
    required this.singleChatEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GestureDetector(
        onTap: () {
          _checkAndShowJoinConfirmation(
            context,
            hobby.groupName ?? '',
            singleChatEntity,
          );
        },
        child: Container(
          height: 195,
          width: 330,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 155, 155, 155),
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(2.0, 0.5),
                blurRadius: 12.0,
                spreadRadius: 3.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Image.network(
                hobby.groupProfileImage ?? '',
                width: 330,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                hobby.groupName ?? '',
                style: const TextStyle(
                  color: Color.fromARGB(255, 181, 93, 190),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkAndShowJoinConfirmation(BuildContext context, String title,
      SingleChatEntity singleChatEntity) async {
    final user = FirebaseAuth.instance.currentUser;

    final messages = await FirebaseFirestore.instance
        .collection("groupChatChannel")
        .doc(singleChatEntity.groupId)
        .collection("messages")
        .get();

    final isAlreadyExist = messages.docs
        .where((doc) => doc.exists && doc['senderId'] == user!.uid)
        .isNotEmpty;

    if (isAlreadyExist) {
      // Navigate to the chat screen with existing data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            title: hobby.groupName ?? '',
            singleChatEntity: singleChatEntity,
          ),
        ),
      );
    } else {
      _openJoinGroupConfirmation(context, title, singleChatEntity);
    }
  }

  void _openJoinGroupConfirmation(
      BuildContext context, String title, SingleChatEntity singleChatEntity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return JoinGroupConfirmation(
          title: title,
          singleChatEntity: singleChatEntity,
        );
      },
    );
  }
}

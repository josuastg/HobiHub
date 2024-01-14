import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobihub/models/chat.dart';

class BubbleChat extends StatelessWidget {
  final Chat chat;
  final bool shouldDisplayName;

  const BubbleChat(
      {super.key, required this.chat, required this.shouldDisplayName});

  @override
  Widget build(BuildContext context) {
    Color bubbleColor =
        chat.isSelfChat ? const Color(0xFFB55DBE) : const Color(0xFFf5f7fb);
    Color messageColor = chat.isSelfChat ? Colors.white : Colors.black;
    Color nameColor =
        Color(int.parse(chat.colorName.replaceAll("#", "0x"))).withOpacity(1.0);

    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(
            top: chat.isSelfChat ? 7 : 7,
            bottom: chat.isSelfChat ? 4 : 4,
            left: chat.isSelfChat ? 0 : 24,
            right: chat.isSelfChat ? 24 : 0),
        child: Container(
          margin: chat.isSelfChat
              ? const EdgeInsets.only(left: 70)
              : const EdgeInsets.only(right: 70),
          padding: const EdgeInsets.only(top: 9, bottom: 3, left: 20, right: 7),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: chat.isSelfChat
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!chat.isSelfChat && shouldDisplayName)
                Text(
                  chat.name,
                  style: TextStyle(
                      color: nameColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              Text(
                chat.text,
                style: TextStyle(
                    color: messageColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                alignment: Alignment.bottomRight,
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${chat.time.hour} : ${chat.time.minute < 10 ? '0${chat.time.minute}' : chat.time.minute}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 188, 188, 188),
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

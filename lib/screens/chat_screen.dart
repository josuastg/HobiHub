import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobihub/group/domain/entities/single_chat_entity.dart';
import 'package:hobihub/group/domain/entities/text_message_entity.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/user/domain/entities/user_entity.dart';
import '../group/presentation/cubits/chat/chat_cubit.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  final SingleChatEntity singleChatEntity;
  const ChatScreen(
      {super.key, required this.title, required this.singleChatEntity});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _previousSenderId = "";
  String username = "";

  Color _getRandomColor(String name) {
    final hash = name.hashCode;
    return Color.fromARGB(
        255, hash % 256, (hash ~/ 256) % 256, (hash ~/ 65536) % 256);
  }

  bool _isButtonSendDisabled() {
    return _messageController.text.isEmpty || _messageController.text == null;
  }

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context)
        .getMessages(channelId: widget.singleChatEntity.groupId!);
    _messageController.addListener(() {
      setState(() {});
    });
    super.initState();
    getUser();
  }

  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  void getUser() async {
    final CollectionReference users = firestore.collection('users');
    final String uid = auth.currentUser!.uid;
    final result = await users.doc(uid).get();
    username = result['fullName'];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 181, 93, 190),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(
                      uid: '',
                    )),
          ),
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<ChatCubit, ChatState>(builder: (context, chatState) {
            if (chatState is ChatLoaded) {
              final messages = chatState.messages;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _messageListWidget(messages),
                  _sendMessageTextField(),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            } else if (chatState is ChatFailure) {
              return const Center(
                child: Text("Failed to send messages!"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _bubbleChatLayout({
    required String text,
    required String time,
    required TextAlign align,
    required CrossAxisAlignment boxAlign,
    required CrossAxisAlignment crossAlign,
    required String name,
    required TextAlign alignName,
    required BubbleNip nip,
    required String senderId,
  }) {
    final isMe = senderId == widget.singleChatEntity.uid;
    final shouldName = !isMe && senderId != _previousSenderId;
    final isFirstMessage = _previousSenderId == senderId;
    final nip = !isFirstMessage
        ? (isMe ? BubbleNip.rightTop : BubbleNip.leftTop)
        : BubbleNip.no;

    _previousSenderId = senderId;

    final textColor = isMe ? Colors.white : Colors.black;
    final nameColor = shouldName ? _getRandomColor(name) : null;
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(3),
            child: Bubble(
              color: isMe
                  ? const Color.fromARGB(255, 181, 93, 190)
                  : const Color.fromARGB(255, 245, 247, 251),
              nip: nip,
              radius: const Radius.circular(11),
              margin: isFirstMessage
                  ? const BubbleEdges.only(right: 6.7, left: 6.7)
                  : null,
              child: Column(
                crossAxisAlignment: crossAlign,
                children: [
                  if (shouldName)
                    Text(
                      "$name",
                      textAlign: alignName,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: nameColor),
                    ),
                  Text(
                    text,
                    textAlign: align,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: textColor),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 12,
                      color: isMe
                          ? Colors.white.withOpacity(.6)
                          : Colors.black.withOpacity(.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _sendMessageTextField() {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 55,
                  child: Card(
                    margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                    color: const Color.fromARGB(243, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: _messageController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20, bottom: 10),
                        border: InputBorder.none,
                        hintText: "Type Your Message...",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(117, 124, 124, 124)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 2),
                  child: CircleAvatar(
                    backgroundColor: _isButtonSendDisabled()
                        ? const Color.fromARGB(243, 230, 230, 230)
                        : const Color.fromARGB(255, 181, 93, 190),
                    radius: 25,
                    child: IconButton(
                      onPressed: _isButtonSendDisabled()
                          ? null
                          : () {
                              BlocProvider.of<ChatCubit>(context)
                                  .sendTextMessage(
                                      textMessageEntity: TextMessageEntity(
                                        time: Timestamp.now(),
                                        content: _messageController.text,
                                        senderName: username,
                                        senderId: widget.singleChatEntity.uid,
                                        type: "TEXT",
                                      ),
                                      channelId:
                                          widget.singleChatEntity.groupId!)
                                  .then((value) => sendNotificationToAllUsers('Group Chat: ${widget.singleChatEntity.groupName}', 'New Message! from $username'));
                              _clear();
                            },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _clear() {
    setState(() {
      _messageController.clear();
    });
  }

  _messageListWidget(List<TextMessageEntity> messages) {
    if (messages.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('No Message avaible...'),
        ),
      );
    }

    if (_scrollController.hasClients) {
      Timer(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      });
    }
    return Expanded(
      child: ListView.builder(
          itemCount: messages.length,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            final singleMessage = messages[index];

            if (singleMessage.senderId == widget.singleChatEntity.uid) {
              return _bubbleChatLayout(
                text: singleMessage.content!,
                time:
                    DateFormat('hh:mm a').format(singleMessage.time!.toDate()),
                align: TextAlign.left,
                boxAlign: CrossAxisAlignment.start,
                crossAlign: CrossAxisAlignment.end,
                name: "Me",
                alignName: TextAlign.end,
                nip: BubbleNip.rightTop,
                senderId: singleMessage.senderId!,
              );
            } else {
              return _bubbleChatLayout(
                text: singleMessage.content!,
                time:
                    DateFormat('hh:mm a').format(singleMessage.time!.toDate()),
                align: TextAlign.left,
                boxAlign: CrossAxisAlignment.start,
                crossAlign: CrossAxisAlignment.start,
                name: "${singleMessage.senderName}",
                alignName: TextAlign.end,
                nip: BubbleNip.leftTop,
                senderId: singleMessage.senderId!,
              );
            }
          }),
    );
  }
}

Future<void> sendNotificationToAllUsers(String title, String content) async {
  try {
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('users').get();

    for (QueryDocumentSnapshot userDoc in usersSnapshot.docs) {
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('token')) {
        String? token = userData['token'];
        if (token != null) {
          await sendPushNotification(token, title, content);
        }
      } else {
        print('Token field does not exist in the users document');
      }
    }
  } catch (e) {
    print('\nsendNotificationToAllUsersError: $e');
  }
}


Future<void> sendPushNotification(
  String token, String title ,String content)async {
    print(UserEntity.token);
  try {
    final body = {
      "to": token,
      "notification": {
        "title": title,
        "body": content,
      },
    };

    var response =
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader:
                  'key= AAAADoPKEH4:APA91bEO2VJ9wlN0Gw1pCMaJ_NRBtQC31MlDKXORcaO0yMHF98Xbmj_htHSHf6FM2SoW5p4nAIBrSXieQmWBjaTTKm6ml-OTTgoQHE6yTanUgMbxxRrNdfjSXfsbAyelnQBnmKpP_DnZ'
            },
            body: jsonEncode(body));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  } 
  catch (e) {
    print('\nsendPushNotificationsError: $e');
  }
}

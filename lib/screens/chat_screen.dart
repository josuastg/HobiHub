import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/user/domain/entities/single_chat_entity.dart';
import 'package:hobihub/user/domain/entities/text_message_entity.dart';
import 'package:hobihub/user/presentation/cubit/chat/chat_cubit.dart';
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

  bool _isButtonSendDisabled() {
    return _messageController.text.isEmpty || _messageController.text == null;
  }

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context)
        .getMessages(channelId: widget.singleChatEntity.groupId);
    _messageController.addListener(() {
      setState(() {});
    });
    super.initState();
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
      body: Column(
        children: [
          BlocBuilder<ChatCubit, ChatState>(builder: (context, chatState) {
            if (chatState is ChatLoaded) {
              final messages = chatState.messages;
              return Column(
                children: [
                  _messageListWidget(messages),
                  _sendMessageTextField(),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          })
        ],
      ),
    );
  }

  Widget _bubbleChatLayout({
    required String text,
    required String time,
    required Color color,
    required TextAlign align,
    required CrossAxisAlignment boxAlign,
    required CrossAxisAlignment crossAlign,
    required String name,
    required TextAlign alignName,
    required BubbleNip nip,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$name",
                    textAlign: alignName,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text,
                    textAlign: align,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(
                        .4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
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
                                  senderName: widget.singleChatEntity.username,
                                  senderId: widget.singleChatEntity.uid,
                                  type: "TEXT",
                                ),
                                channelId: widget.singleChatEntity.groupId,
                              );
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
                color: const Color.fromARGB(255, 181, 93, 190),
                align: TextAlign.left,
                boxAlign: CrossAxisAlignment.start,
                crossAlign: CrossAxisAlignment.end,
                name: "Me",
                alignName: TextAlign.end,
                nip: BubbleNip.rightTop,
              );
            } else {
              return _bubbleChatLayout(
                text: singleMessage.content!,
                time:
                    DateFormat('hh:mm a').format(singleMessage.time!.toDate()),
                color: Colors.grey,
                align: TextAlign.left,
                boxAlign: CrossAxisAlignment.start,
                crossAlign: CrossAxisAlignment.start,
                name: "${singleMessage.senderName}",
                alignName: TextAlign.end,
                nip: BubbleNip.leftTop,
              );
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hobihub/models/chat.dart';
import 'package:hobihub/screens/home_screen.dart';
import 'package:hobihub/widgets/bubble_chat.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  const ChatScreen({super.key, required this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _massageController = TextEditingController();

  bool _isButtonSendDisabled() {
    return _massageController.text.isEmpty || _massageController.text == null;
  }

  @override
  Widget build(BuildContext context) {
    List<Chat> chatBubbles = [
      Chat(
          text: "Hey everyone! What's up?",
          name: "Ering Haaland",
          colorName: "#2A27CE",
          isSelfChat: false,
          time: DateTime.now()),
      Chat(
          text: "Any exciting sports events happening lately?",
          name: "Ering Haaland",
          colorName: "#2A27CE",
          isSelfChat: false,
          time: DateTime.now()),
      Chat(
          text: "Hey! I just watched an incredible soccer match last night.",
          name: "Me",
          colorName: "#FF0000",
          isSelfChat: true,
          time: DateTime.now()),
      Chat(
          text: "The goals were insane!",
          name: "Me",
          colorName: "#FF0000",
          isSelfChat: true,
          time: DateTime.now()),
      Chat(
          text: "Nice! Which teams were playing?",
          name: "Kylian Mbappe",
          colorName: "#CE2781",
          isSelfChat: false,
          time: DateTime.now()),
      Chat(
          text:
              "It was Liverpool vs. Manchester City. The energy on the field was unbelievable.",
          name: "Me",
          colorName: "#FF0000",
          isSelfChat: true,
          time: DateTime.now()),
      Chat(
          text: "Oh, I missed that one. Who won?",
          name: "Karim Benzema",
          colorName: "#8E27CE",
          isSelfChat: false,
          time: DateTime.now()),
      Chat(
          text: "its Manchester City have won against Liverpool!",
          name: "Me",
          colorName: "#8E27CE",
          isSelfChat: true,
          time: DateTime.now()),
    ];

    List<bool> shouldDisplayNameList = [
      for (int index = 0; index < chatBubbles.length; index++)
        index == 0 ||
            chatBubbles[index].isSelfChat != chatBubbles[index - 1].isSelfChat,
    ];

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
            MaterialPageRoute(builder: (context) => const HomePage(uid: '',)),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: chatBubbles.length,
                itemBuilder: (context, index) {
                  return BubbleChat(
                      chat: chatBubbles[index],
                      shouldDisplayName: shouldDisplayNameList[index]);
                }),
          ),
          SizedBox(
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
                          margin: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 8),
                          color: const Color.fromARGB(243, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            controller: _massageController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, bottom: 10),
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
                            onPressed: _isButtonSendDisabled() ? null : () {},
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
          ),
        ],
      ),
    );
  }
}

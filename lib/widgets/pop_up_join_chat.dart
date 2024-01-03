import 'package:flutter/material.dart';
import 'package:hobihub/screens/chat_screen.dart';

class JoinGroupConfirmation extends StatelessWidget {
  final String title;

  const JoinGroupConfirmation({super.key, required this.title});

  void navigateToChatScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(title: title),
      ),
    );
  }

  void closeDialogAndNavigateToHomePage(BuildContext context) {
    Navigator.pop(context); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = '';
    String contentText = '';
    String contentTitle = '';

    // Set image path and content text based on the title
    switch (title.toLowerCase()) {
      case 'sports':
        imagePath = 'assets/images/pop_sports.png';
        contentTitle = "Welcome to the Sports Discussion Forum!";
        contentText =
            "Discover a passionate community to discuss your favorite sports. "
            "Ask questions, share experiences, and provide advice to fellow sports enthusiasts. "
            "Join now to celebrate the joy of sports with us!";
        break;
      case 'music':
        imagePath = 'assets/images/pop_music.png';
        contentTitle = "Welcome to the Music Enthusiasts Forum!";
        contentText =
            "Immerse yourself in a vibrant community where you can discuss your favorite music. "
            "Ask questions, share musical experiences, and offer recommendations to fellow music lovers. "
            "Join us now to harmonize with the joy of music.";
        break;
      case 'traveling':
        imagePath = 'assets/images/pop_travelling.png';
        contentTitle = "Welcome to the Travel Enthusiasts Forum!";
        contentText =
            "Explore a vibrant community where you can discuss your favorite adventures and destinations. "
            "Ask questions, share experiences, and offer recommendations to fellow travel enthusiasts. "
            "Join us now to celebrate the joy of exploring the world together!";
        break;
      case 'games':
        imagePath = 'assets/images/pop_games.png';
        contentTitle = "Welcome to the Games Enthusiasts Forum!";
        contentText =
            "Join an enthusiastic group where you can discuss your favorite games, ask questions, share gaming experiences, "
            "and provide recommendations to fellow gamers. Dive into the world of gaming with us. "
            "Join now and let's celebrate the excitement of gaming together!";
        break;
      default:
        break;
    }

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              imagePath,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 7),
            Text(
              contentTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13, //
                fontWeight: FontWeight.w600,
                color: Color(0xFFB55DBE),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              contentText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFFB55DBE),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    navigateToChatScreen(context);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                      color: Color.fromARGB(255, 181, 93, 190),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Join',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 181, 93, 190),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    closeDialogAndNavigateToHomePage(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 181, 93, 190),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Later',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

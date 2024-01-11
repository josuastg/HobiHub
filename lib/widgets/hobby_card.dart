import 'package:flutter/material.dart';
import 'package:hobihub/models/hobby.dart';
import 'package:hobihub/widgets/pop_up_join_chat.dart';

class HobbyCard extends StatelessWidget {
  final Hobby hobby;

  const HobbyCard({super.key, required this.hobby});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: GestureDetector(
        onTap: () {
          _openJoinGroupConfirmation(context, hobby.title);
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
                hobby.imageUrl,
                width: 330,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('Could not load image');
                },
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                hobby.title,
                style: const TextStyle(
                    color: Color.fromARGB(255, 181, 93, 190),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openJoinGroupConfirmation(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return JoinGroupConfirmation(title: title);
      },
    );
  }
}

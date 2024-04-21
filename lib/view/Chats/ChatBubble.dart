import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 42, 140, 220),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16,color: Colors.white),
      ),
    );
  }
}

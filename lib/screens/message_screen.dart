import 'package:flutter/material.dart';

import '../widgets/chat_message.dart';
import '../widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: ChatMessages(),
        ),
        NewMessage(),
      ],
    );
  }
}

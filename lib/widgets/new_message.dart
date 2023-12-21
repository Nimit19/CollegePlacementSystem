import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';

class NewMessage extends ConsumerStatefulWidget {
  const NewMessage({super.key});

  @override
  ConsumerState<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends ConsumerState<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    _messageController.clear();
    FocusScope.of(context).unfocus();

    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userData = await FirebaseFirestore.instance
        .collection('studentsInfo')
        .doc(userId)
        .get();

    final userProfileUrl = await FirebaseFirestore.instance
        .collection('studentsProfile')
        .doc(userId)
        .get();
    final authData = ref.watch(authenticationProvider);
    final isAdmin = authData.isAdmin(userId);
    await FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': userId,
      'username': isAdmin
          ? "Admin"
          : "${userData.data()!['firstName']} ${userData.data()!['lastName']}",
      'userImage': userProfileUrl.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Send a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            maxRadius: 25,
            child: IconButton(
              onPressed: _submitMessage,
              icon: const Icon(
                Icons.send,
                size: 20,
                color: Colors.black87,
              ),
            ),
          ),
          // IconButton(
          //   onPressed: _submitMessage,
          //   icon: Icon(
          //     Icons.send,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          // )
        ],
      ),
    );
  }
}

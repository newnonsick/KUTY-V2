import 'package:flutter/material.dart';

class ChatPageMobileLayout extends StatefulWidget {
  const ChatPageMobileLayout({super.key});

  @override
  State<ChatPageMobileLayout> createState() => _ChatPageMobileLayoutState();
}

class _ChatPageMobileLayoutState extends State<ChatPageMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt_1),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      ),
    );
  }
}
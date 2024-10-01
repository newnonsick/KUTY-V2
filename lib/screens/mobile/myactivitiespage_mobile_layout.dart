import 'package:flutter/material.dart';

class MyActivitiesPageMobileLayout extends StatefulWidget {
  const MyActivitiesPageMobileLayout({super.key});

  @override
  State<MyActivitiesPageMobileLayout> createState() => _MyActivitiesPageMobileLayoutState();
}

class _MyActivitiesPageMobileLayoutState extends State<MyActivitiesPageMobileLayout> {
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
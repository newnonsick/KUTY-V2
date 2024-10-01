import 'package:flutter/material.dart';
import 'package:ku_ty/screens/mobile/accountpage_mobile_layout.dart';
import 'package:ku_ty/screens/mobile/chatpage_mobile_layout.dart';
import 'package:ku_ty/screens/mobile/homepage_mobile_layout.dart';
import 'package:ku_ty/screens/mobile/myactivitiespage_mobile_layout.dart';
import 'package:ku_ty/widgets/custom_navigationbar.dart';

class MyHomePageMobileLayout extends StatefulWidget {
  final int assignedIndex;
  const MyHomePageMobileLayout({super.key, this.assignedIndex = 0});

  @override
  State<MyHomePageMobileLayout> createState() => _MyHomePageMobileLayoutState();
}

class _MyHomePageMobileLayoutState extends State<MyHomePageMobileLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageMobileLayout(),
    const MyActivitiesPageMobileLayout(),
    const ChatPageMobileLayout(),
    const AccountPageMobileLayout(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.assignedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: _pages[_selectedIndex],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.1),
              //     blurRadius: 20,
              //     spreadRadius: 3,
              //   ),
              // ],
            ),
            child: CustomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

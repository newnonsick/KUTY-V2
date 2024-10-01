import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.1),
        //     spreadRadius: 0,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(
            height: 1,
            thickness: 0.2,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const SizedBox(width: 5),
              _buildButton(Icons.home, selectedIndex, onItemTapped, 0, "Home"),
              _buildButton(Icons.calendar_today_outlined, selectedIndex,
                  onItemTapped, 1, "My Events"),
              _buildButton(
                  Icons.chat, selectedIndex, onItemTapped, 2, "Chat"),
              _buildButton(
                  Icons.person, selectedIndex, onItemTapped, 3, "Account"),
              const SizedBox(width: 5),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

Widget _buildButton(IconData icon, int selectedIndex,
    ValueChanged<int> onItemTapped, int index, String name) {
  return Expanded(
    child: TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            return Colors.transparent;
          },
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,
              size: 30,
              //color #02BC77
              color: selectedIndex == index
                  ? const Color(0xFF02BC77)
                  : Colors.grey),
          Text(
            name,
            style: TextStyle(
              fontSize: 11,
              color: selectedIndex == index
                  ? const Color(0xFF02BC77)
                  : Colors.grey,
            ),
          ),
        ],
      ),
      onPressed: () => onItemTapped(index),
    ),
  );
}

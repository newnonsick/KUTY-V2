import 'package:flutter/material.dart';

class MyHomePageTabletLayout extends StatelessWidget {
  const MyHomePageTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF02BC77), // Apply theme color
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Adds padding for aesthetics
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: Colors.white, // Icon color to contrast with background
              ),
              SizedBox(height: 20), // Adds spacing between icon and text
              Text(
                "Oops! Tablet/Desktop view isn't supported yet.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Adds spacing for text
              Text(
                "We’re working to add support for larger screens.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

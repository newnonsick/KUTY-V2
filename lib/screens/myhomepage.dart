import 'package:flutter/material.dart';
import 'package:ku_ty/screens/mobile/loginpage_mobile_layout.dart';
import 'package:ku_ty/screens/mobile/myhomepage_mobile_layout.dart';
import 'package:ku_ty/screens/teblet/myhomepage_tablet_layout.dart';
import 'package:ku_ty/services/authservice.dart';
import 'package:ku_ty/utils/responsive_layout.dart';

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      // mobile: MyHomePageMobileLayout(
      //   assignedIndex: 0,
      // ),
      mobile: AuthService.checkIsLoggedIn()
          ? const MyHomePageMobileLayout(assignedIndex: 0)
          : const LoginPageMobileLayout(),
      tablet: const MyHomePageTabletLayout(),
    );
  }
}

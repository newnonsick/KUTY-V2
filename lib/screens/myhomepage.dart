import 'package:flutter/material.dart';
import 'package:ku_ty/screens/mobile/loginpage_mobile_layout.dart';
import 'package:ku_ty/screens/teblet/myhomepage_tablet_layout.dart';
import 'package:ku_ty/utils/responsive_layout.dart';

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      // mobile: MyHomePageMobileLayout(
      //   assignedIndex: 0,
      // ),
      mobile: LoginPageMobileLayout(),
      tablet: MyHomePageTabletLayout(),
    );
  }
}

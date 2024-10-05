import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ku_ty/screens/mobile/createeventpage_mobile_layout.dart';
import 'package:ku_ty/screens/mobile/loginpage_mobile_layout.dart';
import 'package:ku_ty/screens/mobile/searchpage_mobile_layout.dart';
import 'package:ku_ty/screens/myhomepage.dart';
import 'package:ku_ty/screens/teblet/myhomepage_tablet_layout.dart';
import 'package:ku_ty/services/authservice.dart';
import 'package:ku_ty/utils/responsive_layout.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  await AuthService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
            name: '/home',
            page: () {
              return const MyHomepage();
            }),
        GetPage(
            name: '/search',
            page: () {
              if (AuthService.checkIsLoggedIn()) {
                return const ResponsiveLayout(
                    mobile: SearchPageMobileLayout(),
                    tablet: MyHomePageTabletLayout());
              } else {
                return const ResponsiveLayout(
                    mobile: LoginPageMobileLayout(),
                    tablet: MyHomePageTabletLayout());
              }
            },
            transition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 300)),
        GetPage(
            name: '/create-event',
            page: () {
              if (AuthService.checkIsLoggedIn()) {
                return const ResponsiveLayout(
                    mobile: CreateEventPageMobileLayout(),
                    tablet: MyHomePageTabletLayout());
              } else {
                return const ResponsiveLayout(
                    mobile: LoginPageMobileLayout(),
                    tablet: MyHomePageTabletLayout());
              }
            },
            transition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 300)),
      ],
      theme: ThemeData(fontFamily: 'Fredoka', primarySwatch: Colors.green),
      home: const MyHomepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_wall/auth/auth_page.dart';
import 'package:social_wall/auth/login_or_register.dart';
import 'package:social_wall/firebase_options.dart';
import 'package:social_wall/pages/home_page.dart';
import 'package:social_wall/pages/profile_page.dart';
import 'package:social_wall/pages/user_page.dart';
import 'package:social_wall/theme/dark_mode.dart';
import 'package:social_wall/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    return MaterialApp(
      title: "Social Wall",
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        "/loginOrRegister": (context) => const LoginOrRegister(),
        "/homePage": (context) => HomePage(),
        "/profilePage": (context) => ProfilePage(),
        "/userPage": (context) => const UserPage(),
      },
    );
  }
}

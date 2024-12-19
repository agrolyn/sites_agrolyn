import 'package:agrolyn_web/view/auth/login_page.dart';
import 'package:agrolyn_web/view/auth/register_page.dart';
import 'package:agrolyn_web/view/community/community_page.dart';
import 'package:agrolyn_web/view/detection/detection_page.dart';
import 'package:agrolyn_web/view/education/education_page.dart';
import 'package:agrolyn_web/view/home/home_page.dart';
import 'package:agrolyn_web/view/recipe/recipe_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/community': (context) => const CommunityPage(),
        '/detection': (context) => const DetectionPage(),
        '/recipe': (context) => const RecipePage(),
        '/education': (context) => const EducationPage(),
      },
    );
  }
}

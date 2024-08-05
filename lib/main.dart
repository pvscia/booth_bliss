import 'package:flutter/material.dart';
import 'view/splash_screen.dart';
import 'view/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      // home: LoginPage(),
    );
  }
}


import 'package:booth_bliss/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/01_Front_page/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //ensure that the Flutter engine is properly initialized before you run any code that depends on it
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

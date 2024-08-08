import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/splash_screen.dart';
import 'test.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //ensure that the Flutter engine is properly initialized before you run any code that depends on it 
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SplashScreen(),
      home: AddDataPage(),
    );
  }
}


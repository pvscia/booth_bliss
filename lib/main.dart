import 'package:booth_bliss/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/splash_screen.dart';
import 'view/login_view.dart';
import 'test.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //ensure that the Flutter engine is properly initialized before you run any code that depends on it
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      home: SplashScreen(),
=======
      // home: LoginPage(),
      home: SplashScreen(),
      // home: AddDataPage(),
>>>>>>> 761ff64580159498570be45299ec90bb816cfcfc
    );
  }
}

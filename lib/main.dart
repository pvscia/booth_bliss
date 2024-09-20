import 'package:booth_bliss/firebase_options.dart';
import 'package:booth_bliss/view/01_Front_page/login_view.dart';
import 'package:booth_bliss/view/01_Front_page/sign_in_up_view.dart';
import 'package:booth_bliss/view/01_Front_page/sign_up_view.dart';
import 'package:booth_bliss/view/main_screen_view.dart';
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

final routes = {
  '/': (BuildContext context) => SplashScreen(),
  '/login': (BuildContext context) => LoginPage(),
  '/register': (BuildContext context) => SignUpPage(),
  '/front_page': (BuildContext context) => SignInUpView(),
  '/home': (BuildContext context) => MainScreen(),
};

// TODO change all routes nav using named

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
    );
  }
}

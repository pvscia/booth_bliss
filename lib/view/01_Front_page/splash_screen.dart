import 'package:booth_bliss/controller/auth_check.dart';
import 'package:flutter/material.dart';
import 'sign_in_up_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
        Duration(seconds: 5), () {}); // Duration for the splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => AuthCheck()), // Navigate to your main screen
      //   MaterialPageRoute(
      //       builder: (context) => MyApp()), // Navigate to homescreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/logo.png',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

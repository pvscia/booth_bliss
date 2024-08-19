import 'package:booth_bliss/view/login_view.dart';
import 'package:booth_bliss/view/sign_in_up_view.dart';
import 'package:booth_bliss/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import '../controller/main_controller.dart';

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
    await Future.delayed(Duration(seconds: 5), () {}); // Duration for the splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInUpView()), // Navigate to your main screen
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
              'lib/assets/logo.png', // Path to your logo image
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

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
      MaterialPageRoute(builder: (context) => MainScreen()), // Navigate to your main screen
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
            SizedBox(height: 20),
            Text(
              'CREATE UNIQUE MEMORIES EASILY',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Login screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                foregroundColor: Colors.white, // Text color
              ),
              child: Text('Log in'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to Sign Up screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink, // Background color
                foregroundColor: Colors.white, // Text color
              ),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

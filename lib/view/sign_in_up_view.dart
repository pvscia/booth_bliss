import 'package:booth_bliss/view/login_view.dart';
import 'package:booth_bliss/view/sign_up_view.dart';
import 'package:flutter/material.dart';

class SignInUpView extends StatelessWidget {
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
                // Navigate to the Login Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
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
                // Navigate to the Sign Up Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
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

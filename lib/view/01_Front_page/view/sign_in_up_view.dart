import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utils/view_dialog_util.dart';

class SignInUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: ViewDialogUtil.checkConnection(), // Check internet connection
      builder: (context, connectionSnapshot) {
        if (connectionSnapshot.connectionState == ConnectionState.waiting) {
          // Show loading while checking connection
          return Scaffold(
            backgroundColor: Color(0xFFF3FDE8),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (connectionSnapshot.hasData && !connectionSnapshot.data!) {
          // No internet connection, show dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ViewDialogUtil().showNoConnectionDialog(
              context,
                  () => SystemNavigator.pop(), // Action for the dialog button
            );
          });

          // Return a placeholder widget to keep the UI in loading state
          return Scaffold(
            backgroundColor: Color(0xFFF3FDE8),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Internet is connected, continue to the UI
        return Scaffold(
          backgroundColor: Color(0xFFF3FDE8),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png', // Path to your logo image
                  width: 300,
                  height: 230,
                ),

                // Outlined Text
                Stack(
                  children: [
                    // Outline
                    Text(
                      'CREATE UNIQUE MEMORIES EASILY',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'MontserratExtraBold',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2 // Thickness of the outline
                          ..color = Color(0xFF804040), // Outline color
                      ),
                    ),
                    // Filled Text
                    Text(
                      'CREATE UNIQUE MEMORIES EASILY',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'MontserratExtraBold',
                        color: Color(0xFFFFBFBF), // Fill color
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Login Page
                    Navigator.of(context).pushNamed("/login");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA8DF8E), // Background color
                      foregroundColor: Colors.white, // Text color
                      minimumSize: Size(300, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    'Log in',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Sign Up Page
                    Navigator.of(context).pushNamed("/register");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE5E5), // Background color
                      foregroundColor: Colors.black, // Text color
                      minimumSize: Size(300, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

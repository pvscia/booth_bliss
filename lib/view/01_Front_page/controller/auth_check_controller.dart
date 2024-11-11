import 'package:booth_bliss/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../07_Photobooth_Start_Page/start_view.dart';
import '../../bottom_nav_bar_view.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return !kIsWeb ? StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // User is logged in
          User? firebaseUser = snapshot.data;

          return FutureBuilder<UserModel?>(
            future: getUserModel(firebaseUser!.email), // Retrieve user data
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (userSnapshot.hasData) {
                  // UserModel is ready, navigate to the home screen after the build phase
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => BottomNavBarMain(idx: 0), // The page you want to navigate to
                      ),
                  );
                } else {
                  // If there's no user data, show an error or redirect to login
                  Navigator.pushReplacementNamed(context, '/front_page');
                }
              });

              return SizedBox(); // Temporary widget until navigation is complete
            },
          );
        } else {
          // User is not logged in, redirect to login screen after the build phase
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/front_page');
          });

          return SizedBox(); // Temporary widget until navigation is complete
        }
      },
    )
        : PhotoboothStartView();
  }

  Future<UserModel?> getUserModel(String? email) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}

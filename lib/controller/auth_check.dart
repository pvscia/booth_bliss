import 'package:booth_bliss/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // User is logged in
          User? firebaseUser = snapshot.data;

          // Fetch the user's Firestore data and create a UserModel
          return FutureBuilder<UserModel?>(
            future: getUserModel(firebaseUser!.uid), // Retrieve user data
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (userSnapshot.hasData) {
                // UserModel is ready, navigate to the home screen
                Future.microtask(() => Navigator.pushReplacementNamed(
                    context, '/home',
                    arguments: {'user' : userSnapshot.data!, 'index' : 0}));
              } else {
                // If there's no user data, show an error or redirect to login
                Future.microtask(() =>
                    Navigator.pushReplacementNamed(context, '/front_page'));
              }

              return SizedBox(); // Temporary widget until navigation is complete
            },
          );
        } else {
          // User is not logged in, redirect to login screen
          Future.microtask(
              () => Navigator.pushReplacementNamed(context, '/front_page'));

          return SizedBox(); // Temporary widget until navigation is complete
        }
      },
    );
  }

  Future<UserModel?> getUserModel(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
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

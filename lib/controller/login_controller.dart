import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booth_bliss/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  Future<UserModel?> login(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      }
      return null;
    } catch (e) {
      return null;
    }

    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid) // Document ID
              // .doc('3FezHRZmHwXPILxNrHwlktxwMUT2') // Document ID
              .get();

      if (doc.exists) {
        // Convert Firestore document to ModelUser
        print(doc.data()!);
        UserModel user = UserModel.fromJson(doc.data()!);
        return user; // Return the user model
      } else {
        return null; // Invalid login
      }
    } catch (e) {
      return null;
    }
  }
}

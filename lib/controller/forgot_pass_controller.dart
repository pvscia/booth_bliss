import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordController {
  final TextEditingController emailController = TextEditingController();
  String emailError = '';
  bool isButtonEnabled = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to check if the email exists and send the reset email
  Future<String> sendPasswordResetEmail() async {
    String email = emailController.text.trim();

    // Validate if the email is empty or invalid
    if (email.isEmpty || !email.contains('@')) {
      return 'This email address is not valid';
    }

    try {
      // Check if the email exists in Firebase Authentication
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.length == 1) {
        // If email exists, send the password reset email
        FirebaseAuth.instance.setLanguageCode('en');
        await _auth.sendPasswordResetEmail(email: email);
        return 'success'; // Indicate success
      } else {
        return 'This email address has no account';
      }
    } on FirebaseAuthException catch (e) {
      return 'Failed to send reset email: ${e.message}';
    }
  }

  // Validate the email before enabling the reset button
  void validateEmail() {
    String email = emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      emailError = 'This email address is not valid';
      isButtonEnabled = false;
    } else {
      emailError = '';
      isButtonEnabled = true;
    }
  }

  // Dispose method to clean up the controller
  void dispose() {
    emailController.dispose();
  }
}

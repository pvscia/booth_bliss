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

    // Check if email is empty or invalid
    if (email.isEmpty || !email.contains('@')) {
      return 'This email address is not valid';
    }

    try {
      List<String> signInMethods =
          await _auth.fetchSignInMethodsForEmail(email);

      if (signInMethods.isNotEmpty) {
        // If email exists, send the password reset email
        await _auth.sendPasswordResetEmail(email: email);
        return 'success'; // Indicate success
      } else {
        return 'This email address has no account';
      }
    } on FirebaseAuthException catch (e) {
      return 'Failed to send reset email: ${e.message}';
    }
  }

  // Validate the email before enabling the button
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

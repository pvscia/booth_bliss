import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isFormFilled = false;
  String passwordStrength = '';

  void checkFormFilled() {
    isFormFilled = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void updatePasswordStrength(String password) {
    if (password.length > 8) {
      passwordStrength = 'excellent';
    } else {
      passwordStrength = 'weak';
    }
  }

  Future<bool> addUserDataToFirestore(BuildContext context) async {
    UserCredential user;
    try {
      // Create user with email and password
      user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Send email verification
      await user.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The password provided is too weak.'),
              backgroundColor: Colors.red,
            ),
          );
        });
      } else if (e.code == 'email-already-in-use') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An account already exists for this email.'),
              backgroundColor: Colors.red,
            ),
          );
        });
      } else if (e.code == 'invalid-email') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email format'),
              backgroundColor: Colors.red,
            ),
          );
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error register user, check again'),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
      return false;
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error register user, check again'),
            backgroundColor: Colors.red,
          ),
        );
      });
      return false;
    }

    // Save user data to Firestore
    try {
      final String userId = user.user!.uid;
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(emailController.text);
      await docRef.set({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'bio': null,
        'uid': userId,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add user: $e'),
            backgroundColor: Colors.red,
          ),
        );
      });
      return false;
    }
    return true;
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}

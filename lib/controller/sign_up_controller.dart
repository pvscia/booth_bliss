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
      user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('The account already exists for that email.')));
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }

    try {
      final String userId = user.user!.uid; // Use email as ID or generate a unique ID
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await docRef.set({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'bio': '',
        'profile_pict': {
          'filename': 'dummy.png',
          'fileloc': 'dummyloc',
        },
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add user: $e')),
      );
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


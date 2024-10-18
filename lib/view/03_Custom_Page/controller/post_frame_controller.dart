import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PostFrameController{
  Future<void> postFrame(File image, String desc, List<String> categories,BuildContext context) async {
    try {
      // Generate unique file name for the image
      String fileName = Uuid().v4();
      User? user = FirebaseAuth.instance.currentUser;

      // Upload the image to Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('frames/$fileName.png');
      await storageReference.putFile(image);

      // Save post details in Firestore
      await FirebaseFirestore.instance.collection('frames').add({
        'userEmail': user?.email,
        'description': desc,
        'categories': categories,
        'filename': fileName,
        'timestamp': FieldValue.serverTimestamp(),
      });

    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload frame: $e'),
        ));
      });
    }
  }
}
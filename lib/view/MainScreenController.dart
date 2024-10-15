import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class MainScreenController {
  Future<UserModel?> getUser() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email) // Document ID
          .get();

      if (doc.exists) {
        // Convert Firestore document to ModelUser
        print(doc.data()!);
        UserModel currUser = UserModel.fromJson(doc.data()!);
        return currUser;
      } else {
        return null; // Invalid login
      }
    } catch (e) {
      return null;
    }
  }
}
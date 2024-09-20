import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booth_bliss/model/user_model.dart';

class EditProfileController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Variables to hold the image and bio
  File? profileImage;
  String bio = '';

  // Pick image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
    }
  }

  // Save profile data (bio and profile picture) to Firebase
  Future<void> saveProfile(String bio, UserModel mUSer) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    String? imageUrl;
    if (profileImage != null) {
      // Upload image to Firebase Storage and get the download URL
      String fileName = '${user.uid}.png';
      Reference storageRef = _storage.ref().child('profilePics/$fileName');
      UploadTask uploadTask = storageRef.putFile(profileImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    }

    // Prepare the data to be updated in Firestore
    ProfilePictureModel profilePictureModel = ProfilePictureModel(
      filename: imageUrl != null ? '${user.uid}.png' : '',
      fileloc: imageUrl ?? '',
    );

    UserModel updatedUser = UserModel(
      firstName: mUSer.firstName, 
      lastName: mUSer.lastName, 
      email: user.email!,
      bio: bio,
      createdAt: DateTime.now(), // Ideally, you'd want to keep the original createdAt
      profilePicture: profilePictureModel,
    );

    // Update Firestore user document
    await _firestore.collection('users').doc(user.uid).update(updatedUser.toJson());
  }
}

import 'dart:io';
import 'dart:math';
import 'package:booth_bliss/view/06_Profile_Page/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http; // For downloading the image
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; // For getting app's local storage path
import 'package:booth_bliss/model/user_model.dart';

class EditProfileController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? profileImage;

  // Pick image from the gallery
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
    }
  }

  Future<void> initImageController(String? uid) async {
    try {
      // Fetch image URL from Firebase Storage
      final imageUrl = await ProfileController().fetchPhoto(uid);

      // Check if the imageUrl is null or empty
      if (imageUrl == null || imageUrl.isEmpty) {
        print('Error: No image URL retrieved');
        return;
      }

      // Fetch image data from the valid URL
      var response = await http.get(Uri.parse(imageUrl));

      // Check if the response was successful
      if (response.statusCode == 200) {
        // Get the temporary directory to save the image file
        final directory = await getApplicationDocumentsDirectory();
        final filePath =
            '${directory.path}/profile_image_${Random().nextInt(10000)}.png';

        // Check if the file already exists
        File imageFile = File(filePath);
        if (await imageFile.exists()) {
          // Delete the existing file before replacing it
          await imageFile.delete();
        }

        // Save the new image to the file (this replaces the old image)
        profileImage = await File(filePath).writeAsBytes(response.bodyBytes);

        print('Image saved to: ${profileImage!.path}');
      } else {
        print('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  // Save profile data (first name, last name, bio, and profile picture) to Firebase
  Future<UserModel> saveProfile(
      {required String firstName,
      required String lastName,
      required String bio,
      required UserModel mUser}) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    // Upload the new image only if a new one was selected
    String fileName = '${user.uid}.png';
    final storageRef = _storage.ref().child('profilePics/$fileName');
    if (profileImage != null) {
      await storageRef.putFile(profileImage!);
    } else {
      // Remove the profile picture from Firebase Storage, if it exists
      try {
        await storageRef.delete();
      } catch (e) {
        // Handle error if the file doesn't exist or other errors occur
        print('Failed to delete profile picture: $e');
      }
    }

    UserModel updatedUser = UserModel(
      firstName: firstName,
      lastName: lastName,
      email: user.email!,
      bio: bio,
      uid: mUser.uid,
      createdAt: mUser.createdAt, // Keep the original createdAt
    );

    // Update Firestore user document
    await _firestore
        .collection('users')
        .doc(user.uid)
        .update(updatedUser.toJson());

    return updatedUser;
  }

  void removeProfile(UserModel mUser) {
    User? user = _auth.currentUser;
    if (user == null) throw Exception('No user logged in');
    profileImage = null;
  }
}

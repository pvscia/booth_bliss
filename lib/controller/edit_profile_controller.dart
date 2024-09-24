import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http; // For downloading the image
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; // For getting app's local storage path
import 'package:path/path.dart'
    as path; // For getting the file name from the URLimport 'package:image_picker/image_picker.dart';
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

  Future<void> initImageController(String? fileloc) async {
    if (fileloc == null || fileloc.isEmpty) {
      print('File location is invalid');
      return;
    }

    try {
      // Fetch image data
      var response = await http.get(Uri.parse(fileloc));

      // Check if the response was successful
      if (response.statusCode == 200) {
        // Get the temporary directory to save the image file
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/profile_image.png';

        // Save the image to the file
        profileImage = File(filePath);
        await profileImage!.writeAsBytes(response.bodyBytes);

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

    String? imageUrl =
        mUser.profilePicture!.fileloc; // Use the existing profile picture URL

    // Upload the new image only if a new one was selected
    if (profileImage != null) {
      String fileName = '${user.uid}.png';
      Reference storageRef = _storage.ref().child('profilePics/$fileName');
      UploadTask uploadTask = storageRef.putFile(profileImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    } else {
      // Remove the profile picture from Firebase Storage, if it exists
      if (mUser.profilePicture!.fileloc!.isNotEmpty) {
        String fileName =
            '${user.uid}.png'; // Assuming the file name is the user's UID with a .png extension
        Reference storageRef = _storage.ref().child('profilePics/$fileName');

        try {
          await storageRef.delete();
          print('success'); // Delete the file from Firebase Storage
        } catch (e) {
          // Handle error if the file doesn't exist or other errors occur
          print('Failed to delete profile picture: $e');
        }
      }
    }

    // Prepare the updated user data, using the existing image URL if no new image was uploaded
    ProfilePictureModel profilePictureModel;
    if (profileImage == null) {
      profilePictureModel = ProfilePictureModel();
    } else {
      profilePictureModel = ProfilePictureModel(
        filename: imageUrl != null ? '${user.uid}.png' : '',
        fileloc: imageUrl ?? '',
      );
    }

    UserModel updatedUser = UserModel(
      firstName: firstName,
      lastName: lastName,
      email: user.email!,
      bio: bio,
      createdAt: mUser.createdAt, // Keep the original createdAt
      profilePicture: profilePictureModel,
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

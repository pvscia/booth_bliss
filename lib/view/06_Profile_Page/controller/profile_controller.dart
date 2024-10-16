import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/image_model.dart';

class ProfileController {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> fetchPhoto(String? uid) async {
    String imagePath = 'profilePics/$uid.png';
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }

  Future<List<ImageModel>> fetchCreated(String email) async {
    try {
      // Reference to the Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query Firestore collection 'frames' where the 'email' field matches the user's email
      QuerySnapshot querySnapshot = await firestore
          .collection('frames')
          .where('userEmail', isEqualTo: email)
          .get();

      // Convert the Firestore documents to ImageModel instances
      List<ImageModel> frames = await Future.wait(querySnapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Create the image path based on filename
        String imagePath = 'frames/${data['filename']}.png';
        print(imagePath);
        // Reference the image in Firebase Storage
        final ref = FirebaseStorage.instance.ref().child(imagePath);

        // Fetch the download URL asynchronously
        String url = await ref.getDownloadURL();

        // Return the ImageModel with the correct download URL
        return ImageModel(
          imageUrl: url, // Use the URL instead of the image path
          desc: data['description'],
          categories: List<String>.from(data['categories'] ?? []),
        );
      }).toList());
      return frames;
    } catch (e) {
      print('Error fetching frames: $e');
      return [];
    }
  }
}

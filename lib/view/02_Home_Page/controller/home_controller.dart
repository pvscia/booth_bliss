import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/image_model.dart';
import '../../../model/user_model.dart';

class HomeController{
  Future<List<ImageModel>> fetchFrames() async {
    try {
      // Reference to the Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query Firestore collection 'frames' where the 'email' field matches the user's email
      QuerySnapshot querySnapshot = await firestore
          .collection('frames')
          .get();

      // Convert the Firestore documents to ImageModel instances
      List<ImageModel> frames = await Future.wait(querySnapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Create the image path based on filename
        String imagePath = 'frames/${data['filename']}.png';
        // Reference the image in Firebase Storage
        final ref = FirebaseStorage.instance.ref().child(imagePath);

        // Fetch the download URL asynchronously
        String url = await ref.getDownloadURL();

        UserModel? tempUser = await getUser(data['userEmail']);
        // Return the ImageModel with the correct download URL
        if(tempUser != null){
          return ImageModel(
            imageUrl: url, // Use the URL instead of the image path
            desc: data['description'],
            categories: List<String>.from(data['categories'] ?? []),
            user: tempUser,
          );
        }else{
          return ImageModel(
            imageUrl: url, // Use the URL instead of the image path
            desc: data['description'],
            categories: List<String>.from(data['categories'] ?? []),
            user: tempUser!,
          );
        }
      }).toList());
      return frames;
    } catch (e) {
      print('Error fetching frames: $e');
      return [];
    }
  }

  Future<UserModel?> getUser(String email) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email) // Document ID
          .get();

      if (doc.exists) {
        // Convert Firestore document to ModelUser
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
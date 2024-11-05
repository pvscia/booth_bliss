import 'package:booth_bliss/model/frame_model.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotoboothFrameSelectionController {
  Future<List<FrameModel>> fetchFrames() async {
    try {
      // Reference to the Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query Firestore collection 'frames' where the 'email' field matches the user's email
      QuerySnapshot querySnapshot =
          await firestore.collection('defaults').get();

      // Convert the Firestore documents to FrameModel instances
      List<FrameModel> frames =
          await Future.wait(querySnapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Create the image path based on filename
        String imagePath = 'defaults/${data['filename']}.png';
        // Reference the image in Firebase Storage
        final ref = FirebaseStorage.instance.ref().child(imagePath);

        // Fetch the download URL asynchronously
        String url = await ref.getDownloadURL();

        // Return the FrameModel with the correct download URL
        return FrameModel(frameUrl: url, idx: data['frameIndex']);
      }).toList());
      return frames;
    } catch (e) {
      print('Error fetching frames: $e');
      return [];
    }
  }


  Future<FrameModel?> fetchFramesURL(String? filename) async {
    String imagePath = 'frames/$filename.png';
    try {
      // Reference to the Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query Firestore collection 'frames' where the 'filename' field matches the input filename
      QuerySnapshot<Map<String, dynamic>> doc =
      await firestore.collection('frames').where('filename', isEqualTo: filename).get();

      // Check if we have a matching document
      if (doc.docs.isNotEmpty) {
        // Access the first document
        Map<String, dynamic> data = doc.docs.first.data();

        // Reference to Firebase Storage
        final ref = FirebaseStorage.instance.ref().child(imagePath);
        String url = await ref.getDownloadURL();

        // Ensure URL is fetched successfully
        if (url.isNotEmpty) {
          // Return the FrameModel with URL and frameIndex from Firestore
          return FrameModel(frameUrl: url, idx: data['frameIndex']);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }


}

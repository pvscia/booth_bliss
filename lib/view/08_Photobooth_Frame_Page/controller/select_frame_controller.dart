import 'package:booth_bliss/model/frame_model.dart';
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
        return FrameModel(frameURl: url, idx: data['frameIndex']);
      }).toList());
      return frames;
    } catch (e) {
      print('Error fetching frames: $e');
      return [];
    }
  }
}

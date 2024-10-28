import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DetailController{
  Future<String?> fetchProfilePhoto(String? uid) async {
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

  Future<void> likeFrame(String docID, String email) async {
    final ref = FirebaseFirestore.instance.collection('frames').doc(docID);
    await ref.update({
      'likedBy' : FieldValue.arrayUnion([email])
    });
  }

  Future<void> unlikeFrame(String docID, String email) async {
    final ref = FirebaseFirestore.instance.collection('frames').doc(docID);
    await ref.update({
      'likedBy' : FieldValue.arrayRemove([email])
    });
  }
}
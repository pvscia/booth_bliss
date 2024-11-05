import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QRController {
  Future<bool> addPhotoToAccount(String filename)async{
    try {
      // Reference to Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      String? userEmail = FirebaseAuth.instance.currentUser?.email;

      // Update the document where filename matches
      // Query to get documents where filename matches
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('photos')
          .where('filename', isEqualTo: filename)
          .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        // Loop through each document (there should be only one based on the filename)
        for (var doc in querySnapshot.docs) {
          // Update the userEmail and timestamp fields for the matched document
          await firestore.collection('photos').doc(doc.id).update({
            'userEmail': FieldValue.arrayUnion([userEmail]),
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
        print('User email updated successfully for filename: $filename');
      } else {
        print('No documents found for filename: $filename');
      }
      return true;

    } catch (e) {
      print('Error updating user email: $e');
    }
    return false;
  }

}
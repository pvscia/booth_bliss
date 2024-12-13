import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http; // For downloading the image
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class DetailController {
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
      'likedBy': FieldValue.arrayUnion([email])
    });
  }

  Future<void> unlikeFrame(String docID, String email) async {
    final ref = FirebaseFirestore.instance.collection('frames').doc(docID);
    await ref.update({
      'likedBy': FieldValue.arrayRemove([email])
    });
  }

  Future<bool> deleteFrame(String docID, String filename) async {
    try {
      // Step 1: Fetch the Firestore document
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('frames')
          .doc(docID)
          .get();

      if (!documentSnapshot.exists) {
        print("No document found with ID: $docID");
        return false;
      }

      // Step 2: Attempt to delete the file from Storage
      try {
        await FirebaseStorage.instance.ref('frames/$filename.png').delete();
        print("File deleted from Storage: frames/$filename");
      } catch (e) {
        if (e.toString().contains('object-not-found')) {
          print("File not found in Storage: frames/$filename");
        } else {
          print("Error deleting file from Storage: $e");
          return false; // Exit if the error is not related to missing file
        }
      }

      // Step 3: Delete the document from Firestore
      await FirebaseFirestore.instance
          .collection('frames')
          .doc(docID)
          .delete();
      print("Document deleted from Firestore: $docID");

      return true; // Success
    } catch (e) {
      print("Error deleting frame: $e");
      return false; // Failure
    }
  }


  Future<void> downloadAndSaveImage(String firebaseUrl, String fileName) async {
    try {
      // Fetch image data from the valid URL
      var response = await http.get(Uri.parse(firebaseUrl));

      // Check if the response was successful
      if (response.statusCode == 200) {
        // Get the temporary directory to save the image file
        final directory = await getApplicationDocumentsDirectory();
        final filePath =
            '${directory.path}/save_photo_${fileName}_${Random().nextInt(10000)}.png';

        // Check if the file already exists
        File imageFile = File(filePath);
        if (await imageFile.exists()) {
          // Delete the existing file before replacing it
          await imageFile.delete();
        }

        // Save the new image to the file (this replaces the old image)
        final photoResult =
            await File(filePath).writeAsBytes(response.bodyBytes);

        final result =
            await ImageGallerySaver.saveFile(photoResult.path, name: fileName);
        print("Image saved to gallery: $result");
      }
    } catch (e) {
      print("Error downloading or saving image: $e");
    }
  }

  Future<bool> deletePhotoFromAccount(String filename) async {
    try {
      // Reference to Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      String? userEmail = FirebaseAuth.instance.currentUser?.email;

      // Query Firestore for documents where the filename matches
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('photos')
          .where('filename', isEqualTo: filename)
          .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          // Use FieldValue.arrayRemove to remove the user email from the document
          await firestore.collection('photos').doc(doc.id).update({
            'userEmail': FieldValue.arrayRemove([userEmail]),
          });
        }
        print('User email removed successfully for filename: $filename');
        return true;
      } else {
        print('No documents found for filename: $filename');
        return false;
      }
    } catch (e) {
      print('Error removing user email: $e');
      return false;
    }
  }

}

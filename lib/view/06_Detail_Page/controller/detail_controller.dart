import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http; // For downloading the image
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> downloadAndSaveImage(String firebaseUrl,String fileName) async {
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
        final photoResult = await File(filePath).writeAsBytes(
            response.bodyBytes);

        final result = await ImageGallerySaver.saveFile(photoResult.path,name :fileName);
        print("Image saved to gallery: $result");
      }
    } catch (e) {
      print("Error downloading or saving image: $e");
    }
  }
}
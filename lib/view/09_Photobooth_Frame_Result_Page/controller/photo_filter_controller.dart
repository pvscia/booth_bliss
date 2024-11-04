import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';

class PhotoFilterController{
  Future<Uint8List?> capturePng(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 9);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        // final result = await ImageGallerySaver.saveFile(fileResult.path,name :filename);
        return pngBytes;
        // Save to the gallery using ImageGallerySaver
        // print("Image saved to gallery: $result");
      }
    } catch (e) {
      print("Error during export: $e");
    }
    return null;
  }

  Future<String?> postPhoto(Uint8List pngBytes) async {
    try {
      // Generate unique file name for the image
      String fileName = Uuid().v4();
      // final file = await getTemporaryDirectory();
      // final filePath = join(file.path, fileName);
      // final image = await File(fileName).writeAsBytes(pngBytes);
      // final image = await File(fileName).writeAsBytes(pngBytes);
      final metadata = SettableMetadata(contentType: 'image/png');

      // Upload the image to Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('photos/$fileName.png');
      await storageReference.putData(pngBytes,metadata);

      // Save post details in Firestore
      await FirebaseFirestore.instance.collection('photos').add({
        'userEmail': null,
        'filename': fileName,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return fileName;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class PhotoFilterController{
  Future<File?> capturePng(GlobalKey globalKey) async {
    try {
      var filename = 'captured_widget${Random().nextInt(10000)}.png';
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 9);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        final file = await getTemporaryDirectory();
        final filePath = join(file.path, filename);
        final fileResult = await File(filePath).writeAsBytes(pngBytes);
        // final result = await ImageGallerySaver.saveFile(fileResult.path,name :filename);
        return fileResult;
        // Save to the gallery using ImageGallerySaver
        // print("Image saved to gallery: $result");
      }
    } catch (e) {
      print("Error during export: $e");
    }
    return null;
  }

  Future<String?> postPhoto(File image) async {
    try {
      // Generate unique file name for the image
      String fileName = Uuid().v4();

      // Upload the image to Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('photos/$fileName.png');
      await storageReference.putFile(image);

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
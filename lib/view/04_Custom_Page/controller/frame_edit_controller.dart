import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FrameEditController {
  Future<File?> capturePng(GlobalKey globalKey) async {
    try {
      var filename = 'captured_widget${Random().nextInt(10000)}.png';
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 11);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        final file = await getTemporaryDirectory();
        final filePath = join(file.path, filename);
        final fileResult = await File(filePath).writeAsBytes(pngBytes);
        return fileResult;
        // Save to the gallery using ImageGallerySaver
        // final result = await ImageGallerySaver.saveFile(fileResult.path,name :filename);
        // print("Image saved to gallery: $result");
      }
    } catch (e) {
      print("Error during export: $e");
    }
    return null;
  }
}

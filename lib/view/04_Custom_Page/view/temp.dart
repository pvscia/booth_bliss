import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


void main() {
  runApp(MaterialApp(
    home: TransparentPhotoGrid(),
  ));
}

class TransparentPhotoGrid extends StatefulWidget {
  @override
  _TransparentPhotoGridState createState() => _TransparentPhotoGridState();
}

class _TransparentPhotoGridState extends State<TransparentPhotoGrid> {
  final GlobalKey _globalKey = GlobalKey();
  List<Uint8List?> imageList = List.filled(6, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transparent Photo Grid"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _capturePng,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: _globalKey,
                child:
                Stack(
                  children: [

                    ClipPath(
                      clipper: PhotoGridClipper(),
                      child: Container(
                        color: Colors.blue, // Maintain transparency in the clip path
                      ),
                    ),
                    // Photo Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            // Load an image from assets on tap
                            ByteData bytes = await rootBundle.load('assets/img.png');
                            setState(() {
                              imageList[index] = bytes.buffer.asUint8List();
                            });
                          },
                          child: Container(
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black, width: 2),
                            //   color: Colors.transparent, // Keep the box itself transparent
                            // ),
                            child: Stack(
                              children: [
                                // Display the photo if available
                                if (imageList[index] != null)
                                  Image.memory(
                                    imageList[index]!,
                                    fit: BoxFit.cover,
                                  ),
                                // Create a transparent overlay for unfilled boxes
                                if (imageList[index] == null)
                                  Container(
                                    color: Colors.transparent, // Maintain transparency for unfilled
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Tap on any square to add a photo. When you save, unfilled squares will be transparent.",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _capturePng() async {
    try {
      var filename = 'captured_widget.png';
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        final file = await getTemporaryDirectory();
        final filePath = join(file.path, filename);
        final fileResult = await File(filePath).writeAsBytes(pngBytes);

        // Save to the gallery using ImageGallerySaver
        final result = await ImageGallerySaver.saveFile(fileResult.path,name :filename);
        print("Image saved to gallery: $result");
      }
    } catch (e) {
      print("Error during export: $e");
    }
  }
}

class PhotoGridClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width *3 /7;
    double height = size.height /4;
    // Draw the outer rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRect(Rect.fromLTWH(10, 20, width, height)); // Top left
    path.addRect(Rect.fromLTWH(width + 45, 20, width, height)); // Top left
    path.addRect(Rect.fromLTWH(10, height + 50, width, height)); // Top left
    path.addRect(Rect.fromLTWH(width + 45, height + 50, width, height)); // Top left
    path.addRect(Rect.fromLTWH(10, height * 2 + 80, width, height)); // Top left
    path.addRect(Rect.fromLTWH(width + 45, height * 2 + 80, width, height)); // Top left


    // Set fill type to evenOdd for transparency
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class PhotoFrameClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Define the path for the photo frame outline
    Path path = Path();

    // Define the outer rectangle
    path.addRect(Rect.fromLTRB(0, 0, size.width, size.height));

    // Define the inner rectangle (cutout for the photo)
    double cutoutWidth = size.width * 0.8;  // Adjust cutout width
    double cutoutHeight = size.height * 0.8; // Adjust cutout height
    path.addRect(Rect.fromLTRB((size.width - cutoutWidth) / 2,
        (size.height - cutoutHeight) / 2,
        (size.width + cutoutWidth) / 2,
        (size.height + cutoutHeight) / 2));

    // Use the difference to create the frame outline
    path = Path.combine(ui.PathOperation.difference, path, path);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

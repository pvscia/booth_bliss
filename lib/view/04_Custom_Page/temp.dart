import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhotoGrid(),
    );
  }
}

class PhotoGrid extends StatefulWidget {
  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  final ImagePicker _picker = ImagePicker();
  List<File?> photos = List.generate(6, (index) => null); // 6 photo frames
  Color? backgroundColor = Colors.white; // Default background
  GlobalKey _globalKey = GlobalKey();

  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        photos[index] = File(pickedFile.path);
      });
    }
  }

  Future<void> _exportToPng() async {
    try {
      RenderRepaintBoundary boundary =
      _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();

      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        // Convert ByteData to Uint8List, then save it as a file
        Uint8List pngBytes = byteData.buffer.asUint8List(); // Proper buffer access

        // Save image to gallery
        final result = await ImageGallerySaver.saveImage(
          pngBytes,
          quality: 100,
          name: "exported_image",
        );

        if (result['isSuccess'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Image saved to gallery successfully!"))
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to save image to gallery"))
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to export"))
        );
      }
    } catch (e) {
      print("Error during export: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error during export: $e"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Grid Exporter"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _exportToPng, // Export to PNG on save
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: Container(
                color: backgroundColor,
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _pickImage(index), // Pick image for the selected frame
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          color: Colors.white, // Background of each grid
                        ),
                        child: photos[index] != null
                            ? Image.file(
                          photos[index]!,
                          fit: BoxFit.cover,
                        )
                            : Center(child: Text('Tap to add photo')),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Background Picker (Color)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.color_lens, color: Colors.black),
                  onPressed: () => setState(() {
                    backgroundColor = Colors.white; // Set background color
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.colorize, color: Colors.black),
                  onPressed: () => setState(() {
                    backgroundColor = Colors.blue.shade100; // Change to another color
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





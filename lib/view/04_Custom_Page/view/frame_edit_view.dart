import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;



import 'add_sticker.dart';
import 'add_text.dart';

class FrameEditorView extends StatefulWidget {
  @override
  FrameEditorPageState createState() => FrameEditorPageState();
}

class FrameEditorPageState extends State<FrameEditorView> {
  List<Widget> widgets = [];
  final ImagePicker _picker = ImagePicker();
  bool _showDeletebtn = false;
  bool _isDeleteBtnActive = false;
  Color _bgColor = Colors.white;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        title: Text('Make Frame', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.undo, color: Colors.black),
            onPressed: () {
              // Handle undo
            },
          ),
          IconButton(
            icon: Icon(Icons.redo, color: Colors.black),
            onPressed: () {
              // Handle redo
            },
          ),
          TextButton(
            onPressed: () {
              // Handle done
            },
            child: Text(
              'Done',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Frame Area (Background + Polaroid Frames)
          Expanded(
            child: Stack(
              children: [
                // Background Image
                Center(
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: ClipPath(
                      clipper: PhotoGridClipper(),
                      child: Container(
                        width : MediaQuery.sizeOf(context).width - 50,
                        height : MediaQuery.sizeOf(context).height - 200,
                        decoration: BoxDecoration(
                          color: _bgColor,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/logo.png'), // Your background image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Polaroid Frames
                 Stack(
                   children: [
                     ...widgets,
                     if(_showDeletebtn)
                     Align(
                       alignment: Alignment.bottomCenter,
                       child: Padding(
                         padding: const EdgeInsets.all(60.0),
                         child: Icon(Icons.delete, size: _isDeleteBtnActive ? 38 : 28, color: _isDeleteBtnActive ? Colors.red: Colors.grey,),
                       ),
                     ),
                   ]
                 )
              ],
            ),
          ),

          // Bottom Toolbar
          Container(
            color: Colors.pink[50],
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildToolbarItem(Icons.grid_on, 'Layout'),
                GestureDetector(
                    onTap: () {
                      _showColorPalette(); // Show color palette dialog
                    },
                    child: _buildToolbarItem(Icons.image, 'Backgrounds')
                ),
                GestureDetector(
                  onTap: () async {
                    XFile? imageFile = await _pickImage();

                    if (imageFile != null) {
                      setState(() {
                        widgets.add(
                          ResizableImage(
                            key: Key(widgets.length.toString()),
                            imagePath: imageFile.path,
                            onDragStart: () {
                              if(!_showDeletebtn){
                                setState(() {
                                  _showDeletebtn = true;
                                });
                              }
                            },
                            onDragEnd: (Offset offset, Key? key) {
                              if(_showDeletebtn){
                                setState(() {
                                  _showDeletebtn = false;
                                });
                              }

                              if(offset.dy > (MediaQuery.of(context).size.height-200)){
                                widgets.removeWhere((widget)=> widget.key == key);
                              }
                            },
                            onDragUpdate: (Offset offset, Key? key) {
                              if(offset.dy > (MediaQuery.of(context).size.height-200)){
                                if(!_isDeleteBtnActive){
                                  setState(() {
                                    _isDeleteBtnActive = true;
                                  });
                                }
                              }else{
                                if(_isDeleteBtnActive){
                                  setState(() {
                                    _isDeleteBtnActive = false;
                                  });
                                }
                              }
                            },
                          ),
                        );
                      });
                    }
                  },
                    child: _buildToolbarItem(Icons.emoji_emotions, 'Stickers')
                ),
                GestureDetector(
                  onTap: () {
                      setState(() {
                        widgets.add(
                          ResizableText(
                            key: Key(widgets.length.toString()),
                            onDragStart: () {
                              if(!_showDeletebtn){
                                setState(() {
                                  _showDeletebtn = true;
                                });
                              }
                            },
                            onDragEnd: (Offset offset, Key? key) {
                              if(_showDeletebtn){
                                setState(() {
                                  _showDeletebtn = false;
                                });
                              }

                              if(offset.dy > (MediaQuery.of(context).size.height-200)){
                                widgets.removeWhere((widget)=> widget.key == key);
                              }
                            },
                            onDragUpdate: (Offset offset, Key? key) {
                              if(offset.dy > (MediaQuery.of(context).size.height-200)){
                                if(!_isDeleteBtnActive){
                                  setState(() {
                                    _isDeleteBtnActive = true;
                                  });
                                }
                              }else{
                                if(_isDeleteBtnActive){
                                  setState(() {
                                    _isDeleteBtnActive = false;
                                  });
                                }
                              }
                            },
                          ),
                        );
                      });
                    },
                    child: _buildToolbarItem(Icons.text_fields, 'Text')
                ),
                _buildToolbarItem(Icons.brush, 'Draw'),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Future<XFile?> _pickImage() async {
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    return imageFile;
  }

  Widget _buildToolbarItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ],
    );
  }

  void _showColorPalette() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Background Color'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildColorOptions(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildColorOptions() {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.transparent,
    ];

    return colors.map((color) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _bgColor = color; // Change background color
          });
          Navigator.of(context).pop(); // Close the dialog after selection
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      );
    }).toList();
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
    double gapX = (size.width - (width*2))/3;
    double gapY = ((size.height*7/8) - (height*3))/3;

    // Draw the outer rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRect(Rect.fromLTWH(gapX, gapY, width, height)); // Top left
    path.addRect(Rect.fromLTWH(size.width - width - gapX, gapY, width, height)); // Top left
    path.addRect(Rect.fromLTWH(gapX, height + gapY*2, width, height)); // Top left
    path.addRect(Rect.fromLTWH(size.width - width - gapX,height + gapY*2, width, height)); // Top left
    path.addRect(Rect.fromLTWH(gapX, height*2 + gapY*3, width, height)); // Top left
    path.addRect(Rect.fromLTWH(size.width - width - gapX,height*2 + gapY*3, width, height)); // Top left


    // Set fill type to evenOdd for transparency
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
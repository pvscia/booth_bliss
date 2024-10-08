import 'package:booth_bliss/view/04_Custom_Page/add_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add_sticker.dart';

class FrameEditorView extends StatefulWidget {
  @override
  FrameEditorPageState createState() => FrameEditorPageState();
}

class FrameEditorPageState extends State<FrameEditorView> {
  List<Widget> widgets = [];
  final ImagePicker _picker = ImagePicker();
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
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/logo.png'), // Your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Polaroid Frames
                 Stack(
                   children: widgets,
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
                _buildToolbarItem(Icons.image, 'Backgrounds'),
                GestureDetector(
                  onTap: () async {
                    XFile? imageFile = await _pickImage();

                    if (imageFile != null) {
                      setState(() {
                        widgets.add(
                          ResizableImage(
                            key: UniqueKey(),
                            imagePath: imageFile.path,
                            onRemove: (Key key) {
                              setState(() {
                                widgets.removeWhere((element) => element.key == key);
                              });
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
                            text: '😂🤣',
                            key: UniqueKey(),
                            onRemove: (Key key) {
                              setState(() {
                                widgets.removeWhere((element) => element.key == key);
                              });
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
}

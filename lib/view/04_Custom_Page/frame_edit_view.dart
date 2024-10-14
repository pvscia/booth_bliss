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
  bool _showDeletebtn = false;
  bool _isDeleteBtnActive = false;
  Color _bgColor = Colors.white;
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
                    color: _bgColor,
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/logo.png'), // Your background image
                      fit: BoxFit.cover,
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
}

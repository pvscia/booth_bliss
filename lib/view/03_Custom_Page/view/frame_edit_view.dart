import 'dart:io';

import 'package:booth_bliss/view/03_Custom_Page/view/post_frame_view.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/user_model.dart';
import '../controller/frame_edit_controller.dart';
import 'add_sticker.dart';
import 'add_text.dart';

class FrameEditorView extends StatefulWidget {
  final UserModel user;
  final int idx;

  FrameEditorView({super.key, required this.idx, required this.user});

  @override
  FrameEditorPageState createState() => FrameEditorPageState();
}

class FrameEditorPageState extends State<FrameEditorView> {
  List<Widget> widgets = [];
  final ImagePicker _picker = ImagePicker();
  bool _showDeleteBtn = false;
  bool _isDeleteBtnActive = false;
  Color _bgColor = Colors.white;
  final GlobalKey _globalKey = GlobalKey();
  final FrameEditController controller = FrameEditController();
  int idxClipPath = 1;

  List<CustomClipper<Path>?> clippers = [
    PhotoGrid1Clipper(),
    PhotoGrid2x2Clipper(),
    PhotoGrid2x2StairClipper(),
    PhotoGrid2x3Clipper(),
    PhotoGrid1CircleClipper(),
    PhotoGrid2x3CircleClipper(),
  ];

  @override
  void initState() {
    super.initState();
    idxClipPath = widget.idx;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }
        ViewDialogUtil().showYesNoActionDialog(
            'Changes will not be saved, are you sure to go back?',
            'Yes',
            'No',
            context, () {
          Navigator.of(context).pop();
        }, () {});
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[50],
          elevation: 0,
          title: Text('Make Frame', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              ViewDialogUtil().showYesNoActionDialog(
                  'Changes will not be saved, are you sure to go back?',
                  'Yes',
                  'No',
                  context, () {
                Navigator.of(context).pop();
              }, () {});
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                ViewDialogUtil().showYesNoActionDialog(
                    'Save Frame?', 'Yes', 'No', context, () async {
                  ViewDialogUtil().showLoadingDialog(context);
                  File? result = await controller.capturePng(_globalKey);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pop();
                    if (result != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostFrameView(
                            framePng: result,
                            user: widget.user,
                          ), // The page you want to navigate to
                        ),
                      );
                    }else{
                      ViewDialogUtil().showOneButtonActionDialog(
                          'Error saving frame, try again',
                          'back',
                          'warning.gif',
                          context,
                          (){});
                    }
                  });
                }, () {});
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
            Expanded(
              child: Container(
                color: Colors.pink[50],
                child: Center(
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: SizedBox(
                      width: 148 * 2.3,
                      height: 210 * 2.3,
                      child: Stack(
                        children: [
                          // Background Image
                          ClipPath(
                            clipper: clippers[idxClipPath],
                            child: Container(
                              width: 148 * 2.3,
                              height: 210 * 2.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0,
                                ),
                                color: _bgColor,
                              ),
                            ),
                          ),
                          ...widgets,
                          if (_showDeleteBtn)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.delete,
                                  size: _isDeleteBtnActive ? 38 : 28,
                                  color: _isDeleteBtnActive
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Toolbar
            Container(
              color: Colors.pink[50],
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _showImageGrid, // Call the method to show the grid
                    child: _buildToolbarItem(Icons.grid_on, 'Layout'),
                  ),
                  GestureDetector(
                      onTap: () {
                        _showColorPicker(); // Show color palette dialog
                      },
                      child: _buildToolbarItem(Icons.image, 'Backgrounds')),
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
                                  if (!_showDeleteBtn) {
                                    setState(() {
                                      _showDeleteBtn = true;
                                    });
                                  }
                                },
                                onDragEnd: (Offset offset, Key? key) {
                                  if (_showDeleteBtn) {
                                    setState(() {
                                      _showDeleteBtn = false;
                                    });
                                  }

                                  if (offset.dy >
                                      (MediaQuery.of(context).size.height -
                                          200)) {
                                    widgets.removeWhere(
                                        (widget) => widget.key == key);
                                  }
                                },
                                onDragUpdate: (Offset offset, Key? key) {
                                  if (offset.dy >
                                      (MediaQuery.of(context).size.height -
                                          200)) {
                                    if (!_isDeleteBtnActive) {
                                      setState(() {
                                        _isDeleteBtnActive = true;
                                      });
                                    }
                                  } else {
                                    if (_isDeleteBtnActive) {
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
                      child:
                          _buildToolbarItem(Icons.emoji_emotions, 'Stickers')),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          widgets.add(
                            ResizableText(
                              key: Key(widgets.length.toString()),
                              onDragStart: () {
                                if (!_showDeleteBtn) {
                                  setState(() {
                                    _showDeleteBtn = true;
                                  });
                                }
                              },
                              onDragEnd: (Offset offset, Key? key) {
                                if (_showDeleteBtn) {
                                  setState(() {
                                    _showDeleteBtn = false;
                                  });
                                }

                                if (offset.dy >
                                    (MediaQuery.of(context).size.height -
                                        200)) {
                                  widgets.removeWhere(
                                      (widget) => widget.key == key);
                                }
                              },
                              onDragUpdate: (Offset offset, Key? key) {
                                if (offset.dy >
                                    (MediaQuery.of(context).size.height -
                                        200)) {
                                  if (!_isDeleteBtnActive) {
                                    setState(() {
                                      _isDeleteBtnActive = true;
                                    });
                                  }
                                } else {
                                  if (_isDeleteBtnActive) {
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
                      child: _buildToolbarItem(Icons.text_fields, 'Text')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageGrid() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Layout'),
          content: Container(
            width: double.maxFinite, // Set width for the dialog
            height: 200, // Set height for the dialog
            child: GridView.count(
              crossAxisCount: 2, // 2 columns
              children: [
                _buildGridImage('assets/layout_1.jpg', 0),
                _buildGridImage('assets/layout_2.jpg', 1),
                _buildGridImage('assets/layout_3.jpg', 2),
                _buildGridImage('assets/layout_4.jpg', 3),
                _buildGridImage('assets/layout_5.jpg', 4),
                _buildGridImage('assets/layout_6.jpg', 5),
              ],
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

  Widget _buildGridImage(String assetPath, int idx) {
    return GestureDetector(
      onTap: () {
        setState(() {
          idxClipPath = idx;
        });
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          assetPath,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Future<XFile?> _pickImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);
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

  void _showColorPicker() {
    Color selectedColor =
        _bgColor; // Use the current background color as the initial value

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Background Color'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Color Picker
                ColorPicker(
                  pickerColor: selectedColor,
                  enableAlpha: false,
                  onColorChanged: (Color color) {
                    setState(() {
                      selectedColor = color; // Update the selected color
                    });
                  },
                  pickerAreaHeightPercent: 0.7,
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _bgColor = selectedColor; // Set the background color
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Select Color'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PhotoGrid2x3Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width * 3 / 7;
    double height = size.height / 4;
    double gapX = (size.width - (width * 2)) / 3;
    double gapY = ((size.height * 7 / 8) - (height * 3)) / 3;

    // Draw the outer rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRect(Rect.fromLTWH(gapX, gapY, width, height)); // Top left
    path.addRect(Rect.fromLTWH(
        size.width - width - gapX, gapY, width, height)); // Top left
    path.addRect(
        Rect.fromLTWH(gapX, height + gapY * 2, width, height)); // Top left
    path.addRect(Rect.fromLTWH(size.width - width - gapX, height + gapY * 2,
        width, height)); // Top left
    path.addRect(
        Rect.fromLTWH(gapX, height * 2 + gapY * 3, width, height)); // Top left
    path.addRect(Rect.fromLTWH(size.width - width - gapX, height * 2 + gapY * 3,
        width, height)); // Top left

    // Set fill type to evenOdd for transparency
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class PhotoGrid2x2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width * 3 / 7;
    double height = size.height / 2.5;
    double gapX = (size.width - (width * 2)) / 3;
    double gapY = ((size.height * 7 / 8) - (height * 2)) / 2;

    // Draw the outer rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRect(Rect.fromLTWH(gapX, gapY, width, height)); // Top left
    path.addRect(Rect.fromLTWH(
        size.width - width - gapX, gapY, width, height)); // Top left
    path.addRect(
        Rect.fromLTWH(gapX, height + gapY * 2, width, height)); // Top left
    path.addRect(Rect.fromLTWH(size.width - width - gapX, height + gapY * 2,
        width, height)); // Top left

    // Set fill type to evenOdd for transparency
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class PhotoGrid2x2StairClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width * 3 / 7;
    double height = size.height / 2.5;
    double gapX = (size.width - (width * 2)) / 3;
    double gapY = ((size.height * 7 / 8) - (height * 2)) / 2;

    // Draw the outer rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRect(Rect.fromLTWH(gapX, gapY, width, height)); // Top left
    path.addRect(Rect.fromLTWH(size.width - width - gapX, size.height * 1 / 8,
        width, height)); // Top left
    path.addRect(
        Rect.fromLTWH(gapX, height + gapY * 2, width, height)); // Top left
    path.addRect(Rect.fromLTWH(size.width - width - gapX,
        height + gapY + size.height * 1 / 8, width, height)); // Top left

    // Set fill type to evenOdd for transparency
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class PhotoGrid1Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width * 0.9;
    double height = size.height * 6.5 / 8;
    double gapX = (size.width - width) / 2;
    double gapY = (size.height * 7 / 8) - height;

    // Draw the outer rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addRect(Rect.fromLTWH(gapX, gapY, width, height)); // Top left
    // Set fill type to evenOdd for transparency
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class PhotoGrid1CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width * 0.9;
    double height = size.height * 6.5 / 8;
    double gapX = (size.width - width) / 2;
    double gapY = (size.height * 7 / 8) - height;

    // Draw the outer rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addOval(Rect.fromCircle(
        center: Offset(width / 2 + gapX, width / 2 + gapY),
        radius: width / 2)); // Top left
    // Set fill type to evenOdd for transparency
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class PhotoGrid2x3CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width * 3 / 7;
    double height = size.height / 2.5;
    double gapX = (size.width - (width * 2)) / 3;
    double gapY = ((size.height * 7 / 8) - (height * 2)) / 3;

    // Draw the outer rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addOval(Rect.fromCircle(
        center: Offset(width / 2 + gapX, width / 2 + gapY),
        radius: width / 2)); // Top left
    path.addOval(Rect.fromCircle(
        center: Offset(width / 2 + gapX * 2 + width, width / 2 + gapY),
        radius: width / 2)); // Top left
    path.addOval(Rect.fromCircle(
        center: Offset(width / 2 + gapX, width / 2 + gapY * 2 + width),
        radius: width / 2)); // Top left
    path.addOval(Rect.fromCircle(
        center:
            Offset(width / 2 + gapX * 2 + width, width / 2 + gapY * 2 + width),
        radius: width / 2)); // Top left
    path.addOval(Rect.fromCircle(
        center: Offset(width / 2 + gapX, width / 2 + gapY * 3 + width * 2),
        radius: width / 2)); // Top left
    path.addOval(Rect.fromCircle(
        center: Offset(
            width / 2 + gapX * 2 + width, width / 2 + gapY * 3 + width * 2),
        radius: width / 2)); // Top left
    // Set fill type to evenOdd for transparency
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

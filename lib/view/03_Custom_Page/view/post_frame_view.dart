import 'dart:io';
import 'package:booth_bliss/view/Utils/constant_var.dart';
import 'package:flutter/material.dart';

import '../../../model/user_model.dart';
import '../../Utils/view_dialog_util.dart';
import '../../bottom_nav_bar_view.dart';
import '../controller/post_frame_controller.dart';

class PostFrameView extends StatefulWidget {
  final File framePng;
  final UserModel user;
  final int idxFrame;

  const PostFrameView({super.key, required this.framePng, required this.user, required this.idxFrame});
  @override
  PostFrameViewState createState() => PostFrameViewState();
}

class PostFrameViewState extends State<PostFrameView> {
  final TextEditingController _descriptionController = TextEditingController();
  List<String> selectedCategories = [];
  bool isLoading = false;


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
            context,
                (){
              Navigator.of(context).pop();
            },
                (){});
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Save Frame', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (){
              ViewDialogUtil().showYesNoActionDialog(
                  'Changes will not be saved, are you sure to go back?',
                  'Yes',
                  'No',
                  context,
                      (){
                    Navigator.of(context).pop();
                  },
                      (){});
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                ViewDialogUtil().showYesNoActionDialog(
                    'Save Frame?',
                    'Yes',
                    'No',
                    context,
                        () async {
                          if (_descriptionController.text.isEmpty || selectedCategories.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please complete all fields'),
                            ));
                            return;
                          }
                          ViewDialogUtil().showLoadingDialog(context);
                          PostFrameController().postFrame(widget.framePng, _descriptionController.text, selectedCategories, context, widget.idxFrame);
                          Navigator.of(context).pop();
                          ViewDialogUtil().showOneButtonActionDialog(
                              'Frame Saved',
                              'Ok',
                              'success.gif',
                              context,
                                  (){
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => BottomNavBarMain(idx: 1), // The page you want to navigate to
                                      ),
                                          (Route<dynamic> route) => false, // This removes all the previous routes
                                    );
                                  });
                    },
                        (){});
              },
              child: Text('Save'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: null,//_pickImage,
                  child: Image.file(widget.framePng),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Write a caption...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                Text('Add Category:', style: TextStyle(fontSize: 16)),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Prevents grid from scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 items per row
                    crossAxisSpacing: 8, // Adjust spacing between boxes horizontally
                    mainAxisSpacing: 8, // Adjust spacing between boxes vertically
                    childAspectRatio: 3, // Adjusts height to width ratio for smaller boxes
                  ),
                  itemCount: ConstantVar().categories.length,
                  itemBuilder: (context, index) {
                    String category = ConstantVar().categories[index];
                    bool isSelected = selectedCategories.contains(category);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedCategories.remove(category);
                          } else {
                            selectedCategories.add(category);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4), // Smaller padding
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            textAlign: TextAlign.center, // Center-align text
                            softWrap: true, // Allow text to wrap
                            maxLines: 2, // Max 2 lines of text
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 12, // Smaller font size for wrapping
                            ),
                          ),
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
    );
  }
}

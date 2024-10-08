import 'package:booth_bliss/view/04_Custom_Page/frame_edit_view.dart';
import 'package:flutter/material.dart';

class CustomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Navigate to FrameEditorPage when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FrameEditorView()),
          );
        },
        child: Text('Go to Frame Editor'),
      ),
    );
  }
}

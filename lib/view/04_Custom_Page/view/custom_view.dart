import 'package:flutter/material.dart';

import 'frame_edit_view.dart';

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
            // MaterialPageRoute(builder: (context) => ImageManipulatorPage()),
          );
        },
        child: Text('Go to Frame Editor'),
      ),
    );
  }
}

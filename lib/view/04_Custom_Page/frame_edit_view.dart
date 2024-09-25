import 'package:flutter/material.dart';

class FrameEditorView extends StatefulWidget {
  @override
  _FrameEditorPageState createState() => _FrameEditorPageState();
}

class _FrameEditorPageState extends State<FrameEditorView> {
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
                Positioned(
                  top: 100,
                  left: 30,
                  child: Image.asset('assets/default-user.png',
                      width: 100, height: 120), // Frame 1
                ),
                Positioned(
                  top: 150,
                  left: 180,
                  child: Image.asset('assets/default-user.png',
                      width: 100, height: 120), // Frame 2
                ),
                // Add more frames similarly as needed
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
                _buildToolbarItem(Icons.emoji_emotions, 'Stickers'),
                _buildToolbarItem(Icons.text_fields, 'Text'),
                _buildToolbarItem(Icons.brush, 'Draw'),
              ],
            ),
          ),
        ],
      ),
    );
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

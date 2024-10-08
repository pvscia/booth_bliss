import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';

class ResizableImage extends StatefulWidget {
  final String imagePath;
  final Function(Key) onRemove;

  const ResizableImage({super.key, required this.imagePath, required this.onRemove});

  @override
  ResizableImageState createState() => ResizableImageState();
}

class ResizableImageState extends State<ResizableImage> {
  double _width = 100.0;
  double _height = 100.0;
  Offset _position = Offset(50, 50);
  bool _isFocused = false;
  double _rotation = 0.0; // Rotation in radians
  Offset? _initialDragOffset; // To track the initial drag offset for rotation

  void _toggleFocus(bool focus) {
    setState(() {
      _isFocused = focus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta; // Move the image
          });
          _toggleFocus(true);
        },
        onTap: () {
          _toggleFocus(true);
        },
        onPanEnd: (_) {
          _toggleFocus(false);
        },
        child: Stack(
          children: [
            Transform.rotate(
              angle: _rotation,
              child: Container(
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  border: _isFocused
                      ? Border.all(color: Colors.blue, width: 2)
                      : Border.all(color: Colors.transparent, width: 0),
                ),
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (_isFocused)
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _width = (_width + details.delta.dx).clamp(50.0, double.infinity);
                      _height = (_height + details.delta.dy).clamp(50.0, double.infinity);
                    });
                  },

                  child: const Icon(Icons.zoom_out_map, color: Colors.blue),
                ),
              ),
            if (_isFocused)
              Positioned(
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onPanStart: (details) {
                    _initialDragOffset = details.localPosition; // Track the initial position for rotation
                  },
                  onPanUpdate: (details) {
                    if (_initialDragOffset != null) {
                      // Calculate the center of the image
                      double centerX = _position.dx + _width / 2;
                      double centerY = _position.dy + _height / 2;

                      // Calculate the angle based on the drag movement
                      double deltaX = details.localPosition.dx - centerX;
                      double deltaY = details.localPosition.dy - centerY;

                      // Calculate the angle in radians
                      double newRotation = atan2(deltaY, deltaX);

                      setState(() {
                        // Update the rotation angle
                        _rotation = newRotation % (2 * pi); // Set rotation directly to the calculated angle
                      });
                    }
                  },
                  onPanEnd: (_) {
                    _initialDragOffset = null; // Reset the initial drag offset
                  },
                  child: const Icon(Icons.rotate_right, color: Colors.green),
                ),
              ),
            if (_isFocused)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    widget.onRemove(widget.key!);
                  },
                  child: const Icon(Icons.close, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

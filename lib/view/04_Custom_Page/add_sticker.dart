import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector_pro/matrix_gesture_detector_pro.dart';

class ResizableImage extends StatefulWidget {
  final String imagePath;
  final Function(Key) onRemove;

  const ResizableImage({super.key, required this.imagePath, required this.onRemove});

  @override
  ResizableImageState createState() => ResizableImageState();
}

class ResizableImageState extends State<ResizableImage> {
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      onMatrixUpdate: (m,tm,sm,rm){
        notifier.value = m;
      },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, child) {
          return Transform(
            transform: notifier.value,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    transform: notifier.value,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.file(
                        File(widget.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

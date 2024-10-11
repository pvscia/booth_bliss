import 'dart:io';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

typedef PointMoveCallback = void Function(Offset offset, Key? key);
class ResizableImage extends StatefulWidget {
  final String imagePath;
  final VoidCallback onDragStart;
  final PointMoveCallback onDragEnd;
  final PointMoveCallback onDragUpdate;

  const ResizableImage({super.key,
    required this.imagePath,
    required this.onDragStart,
    required this.onDragEnd,
    required this.onDragUpdate});

  @override
  ResizableImageState createState() => ResizableImageState();
}

class ResizableImageState extends State<ResizableImage> {
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());


  @override
  Widget build(BuildContext context) {
    late Offset offset;

    return Listener(
      onPointerMove: (event){
        offset = event.position;
        widget.onDragUpdate(offset,widget.key);
      },
      child: MatrixGestureDetector(
        onMatrixUpdate: (m,tm,sm,rm){
          notifier.value = m;
        },
        onScaleStart: () {
          widget.onDragStart();
        },
        onScaleEnd: () {
          widget.onDragEnd(offset,widget.key);
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
      ),
    );
  }
}

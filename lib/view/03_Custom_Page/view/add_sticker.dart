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
  final ValueNotifier<Matrix4> notifier2 = ValueNotifier(Matrix4.identity());
  int shapeIndex = 0;
  late Offset offset;

  @override
  Widget build(BuildContext context) {
    List<CustomClipper<Path>?> clippers = [
      null, // Normal shape (no clipper)
      SquareClipper(),
      CircleClipper(),
      LoveClipper(),
      StarClipper(),
    ];


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
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              shapeIndex = (shapeIndex + 1) % clippers.length;
                            });
                          },
                          child: ClipPath(
                            clipper: clippers[shapeIndex],
                            child: Image.file(
                              File(widget.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
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

// Square clipper
class SquareClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.width));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


// Circle clipper
class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var radius = size.width / 2;
    return Path()..addOval(Rect.fromCircle(center: Offset(radius, radius), radius: radius));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Heart (love) clipper
class LoveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.width;

    // Heart shape logic
    path.moveTo(width / 2, height / 4);
    path.cubicTo(5 * width / 6, height / 16, width, height / 3, width / 2, 3 * height / 4);
    path.moveTo(width / 2, height / 4);
    path.cubicTo(width / 6, height / 16, 0, height / 3, width / 2, 3 * height / 4);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Star clipper
class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var width = size.width;
    var height = size.width;

    path.moveTo(width * 0.5, 0);
    path.lineTo(width * 0.61, height * 0.35);
    path.lineTo(width * 1.0, height * 0.35);
    path.lineTo(width * 0.68, height * 0.57);
    path.lineTo(width * 0.79, height * 1.0);
    path.lineTo(width * 0.5, height * 0.73);
    path.lineTo(width * 0.21, height * 1.0);
    path.lineTo(width * 0.32, height * 0.57);
    path.lineTo(0, height * 0.35);
    path.lineTo(width * 0.39, height * 0.35);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
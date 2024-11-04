import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:booth_bliss/view/09_Photobooth_Frame_Result_Page/view/photo_filter_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWithTimer extends StatefulWidget {
  final int currIndex;
  final String frameUrl;

  const CameraWithTimer({
    super.key,
    required this.currIndex, required this.frameUrl,
  });

  @override
  CameraWithTimerState createState() => CameraWithTimerState();
}

class CameraWithTimerState extends State<CameraWithTimer> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  Timer? countdownTimer;
  Timer? previewTimer;
  Duration myDuration = const Duration(seconds: 10);
  bool isPreviewVisible = false;
  Uint8List lastImagePath = Uint8List(0); // Empty Uint8List
  List<Uint8List> imagePaths = [];
  int maxTake = 1;

  @override
  void initState() {
    super.initState();
    if (widget.currIndex == 1 || widget.currIndex == 2) {
      maxTake = 4;
    } else if (widget.currIndex == 3 || widget.currIndex == 5) {
      maxTake = 6;
    }
    _initializeCamera();
    startTimer(); // Start the timer immediately
  }

  void _initializeCamera() {
    availableCameras().then((cameras) {
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _cameraController = CameraController(frontCamera, ResolutionPreset.max);

      // Initialize the camera controller future
      _initializeControllerFuture = _cameraController.initialize();
      setState(() {}); // Trigger rebuild with initialized future
    });
    // availableCameras().then((cameras) {
    //   if (cameras.isNotEmpty) {
    //     // Use the first available camera
    //     _cameraController = CameraController(cameras.first, ResolutionPreset.max);
    //
    //     // Initialize the camera controller future
    //     _initializeControllerFuture = _cameraController.initialize();
    //     setState(() {}); // Trigger rebuild with initialized future
    //   } else {
    //     print("No cameras found");
    //   }
    // }).catchError((e) {
    //   print("Error initializing camera: $e");
    // });
  }

  void startTimer() {
    // Reset the timer duration to 10 seconds for each sequence
    setState(() => myDuration = const Duration(seconds: 10));
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds <= 0) {
        countdownTimer!.cancel();
        capturePhoto();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void cancelPreview() {
    if (previewTimer != null && previewTimer!.isActive) {
      previewTimer!.cancel();
      setState(() {
        isPreviewVisible = false;
      });
      previewAction();
    }
  }

  Future<void> capturePhoto() async {
    if (_cameraController.value.isInitialized) {
      final image = await _cameraController.takePicture();
      final lastPath = await image.readAsBytes();
      setState(() {
        lastImagePath = lastPath;
        imagePaths.add(lastPath);
        isPreviewVisible = true;
      });

      // Show preview for 5 seconds, then continue to the next photo
      previewTimer?.cancel();
      previewTimer = Timer(const Duration(seconds: 5), () {
        previewAction();
      });
    }
  }

  void previewAction() {
    if (!mounted) return;
    setState(() {
      isPreviewVisible = false;
    });
    if (imagePaths.length < maxTake) {
      startTimer(); // Start the timer for the next photo
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PhotoFilter(
            index: widget.currIndex,
            imagePaths: imagePaths,
            frameUrl: widget.frameUrl,
          ), // The page you want to navigate to
        ),
      );
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    countdownTimer?.cancel();
    previewTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final aspectRatio = _cameraController.value.aspectRatio;
              String strDigits(int n) => n.toString();
              final seconds = strDigits(myDuration.inSeconds.remainder(60));

              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: pi/2,
                      // angle: pi *3/2,
                      child: AspectRatio(
                        aspectRatio: aspectRatio,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: SizedBox(
                            width: _cameraController.value.previewSize!.height,
                            height: _cameraController.value.previewSize!.width,
                            child: CameraPreview(_cameraController),
                          ),
                        ),
                      ),
                    ),
                    if (widget.currIndex != 3)
                      Transform.rotate(
                        angle: pi / 2,
                        child: AspectRatio(
                          aspectRatio: aspectRatio,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: ClipPath(
                              clipper: HoleClipper(),
                              // Custom clipper for the cut-out
                              child: Container(
                                width:
                                    _cameraController.value.previewSize!.height,
                                height:
                                    _cameraController.value.previewSize!.width,
                                color: Colors.black
                                    .withOpacity(0.7), // Dark overlay color
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (isPreviewVisible && lastImagePath != null)
                      Stack(children: [
                        Positioned.fill(
                          child: Image.memory(
                            lastImagePath,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Positioned(
                            left: 30,
                            top: 30,
                            child: IconButton(
                                onPressed: () {
                                  imagePaths.removeLast();
                                  cancelPreview();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )))
                      ]),
                    if (!isPreviewVisible)
                      Text(
                        seconds,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 150),
                      ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class HoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = 148 * size.height / 210;
    path.addRect(
        Rect.fromLTWH(0, 0, size.width, size.height)); // Full container
    path.addRect(Rect.fromLTWH(
        0, (size.height - width) / 2, size.width, width)); // Full container

    path.fillType = PathFillType.evenOdd; // This creates the "cut-out" effect
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

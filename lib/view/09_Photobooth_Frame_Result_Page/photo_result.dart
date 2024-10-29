import 'dart:io';

import 'package:flutter/material.dart';

import '../../model/photo_grid_model.dart';

class PhotoGrid extends StatelessWidget {
  final PhotoGridModel gridModel;
  final List<String> imagePaths;
  final String frameUrl;

  const PhotoGrid({
    super.key,
    required this.gridModel,
    required this.imagePaths,
    required this.frameUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 148 * 2.3,
          height: 210 * 2.3,
          child: Stack(
            children: [
              // Loop over the coordinates and create Positioned widgets for each image
              for (int i = 0; i < gridModel.coordinates.length; i++)
                Positioned(
                  left: gridModel.coordinates[i].x,
                  top: gridModel.coordinates[i].y,
                  width: gridModel.width,
                  height: gridModel.height,
                  child: Image.file(
                    File(imagePaths[i]),
                    fit: BoxFit.cover,
                  ),
                ),
              Positioned(
                  left: 0,
                  top: 0,
                  width: 148 * 2.3,
                  height: 210 * 2.3,
                  child: Image.asset(
                    frameUrl,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoboothResult extends StatelessWidget {
  final int index;
  final List<String> imagePaths;

  const PhotoboothResult({
    super.key,
    required this.index,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    List<PhotoGridModel> models = [
      PhotoGridModels.square1,
      PhotoGridModels.square2x2,
      PhotoGridModels.stair2x2,
      PhotoGridModels.square2x3,
      PhotoGridModels.circle1,
      PhotoGridModels.circle2x3,
    ];

    final List<String> images = [
      'assets/layout_1.png',
      'assets/layout_2.png',
      'assets/layout_3.png',
      'assets/layout_4.png',
      'assets/layout_5.png',
      'assets/layout_6.png',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Grid Example'),
      ),
      body: Center(
        child: PhotoGrid(
          gridModel: models[index],
          imagePaths: imagePaths,
          frameUrl: images[index],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:booth_bliss/view/09_Photobooth_Frame_Result_Page/view/photo_result.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/material.dart';

import '../../../model/photo_grid_model.dart';
import '../../Utils/color_filter_var.dart';
import '../controller/photo_filter_controller.dart';

class PhotoFilter extends StatefulWidget {
  final int index;
  final String frameUrl;
  final List<String> imagePaths;

  const PhotoFilter({
    super.key,
    required this.index,
    required this.frameUrl,
    required this.imagePaths, 
  });

  @override
  PhotoFilterState createState() => PhotoFilterState();
}

class PhotoFilterState extends State<PhotoFilter> {
  final GlobalKey _globalKey = GlobalKey();
  List<ColorFilter> filters = ColorFilters.colorFilters;
  late ColorFilter currColor;
  late PhotoGridModel gridModel;
  

  @override
  void initState() {
    super.initState();
    currColor = filters[0];
    gridModel = PhotoGridModels().models[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Apply Filters')),
        actions: [
          TextButton(onPressed: () async {
            ViewDialogUtil().showLoadingDialog(context);
            File? result = await PhotoFilterController().capturePng(_globalKey);
            String? filename = await  PhotoFilterController().postPhoto(result!);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PhotoResult(framePng: result, filename: filename ?? '',)
                ),
              );
                        });
          }, child: Text('Next'))
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: RepaintBoundary(
                      key: _globalKey,
                      child: SizedBox(
                        width: 148 * 2.3,
                        height: 210 * 2.3,
                        child: Stack(
                          children: [
                            // Loop over the coordinates and create Positioned widgets for each image
                            for (int i = 0;
                                i < gridModel.coordinates.length;
                                i++)
                              Positioned(
                                left: gridModel.coordinates[i].x,
                                top: gridModel.coordinates[i].y,
                                width: gridModel.width,
                                height: gridModel.height,
                                child: ColorFiltered(
                                  colorFilter: currColor,
                                  child: Image.file(
                                    File(widget.imagePaths[i]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Positioned(
                                left: 0,
                                top: 0,
                                width: 148 * 2.3,
                                height: 210 * 2.3,
                                child: Image.asset(
                                  widget.frameUrl,
                                  fit: BoxFit.cover,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 2x2 grid
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filters.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currColor = filters[index];
                            });
                          },
                          child: ColorFiltered(
                            colorFilter: filters[index],
                            child: Image.asset(
                              'assets/img_1.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


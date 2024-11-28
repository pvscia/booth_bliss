import 'dart:typed_data';

import 'package:booth_bliss/view/09_Photobooth_Frame_Result_Page/view/photo_result_view.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/material.dart';

import '../../../model/photo_grid_model.dart';
import '../../Utils/color_filter_var.dart';
import '../controller/photo_filter_controller.dart';

class PhotoFilter extends StatefulWidget {
  final int index;
  final String frameUrl;
  final List<Uint8List> imagePaths;

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
        title: Center(child: Text('Pick A Photo Filter')),
        backgroundColor: Color(0xFFF3FDE8),
      ),
      body: Container(
        color: Color(0xFFF3FDE8),
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFF0F5),
                            borderRadius: BorderRadiusDirectional.circular(10)),
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
                                      child: Image.memory(
                                        widget.imagePaths[i],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                Positioned(
                                    left: 0,
                                    top: 0,
                                    width: 148 * 2.3,
                                    height: 210 * 2.3,
                                    child: Image.network(
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
              ),
              Expanded(
                flex: 13,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFF0F5),
                            borderRadius: BorderRadiusDirectional.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            ViewDialogUtil().showLoadingDialog(context);
                            Uint8List? result = await PhotoFilterController()
                                .capturePng(_globalKey);
                            String? filename = await PhotoFilterController()
                                .postPhoto(result!);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => PhotoResult(
                                          filename: filename ?? '',
                                        )),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(300, 60),
                              backgroundColor: Color(0xFFFFF0F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: Text(
                            'Finish',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

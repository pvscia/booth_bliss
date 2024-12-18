import 'package:booth_bliss/view/08_Photobooth_Frame_Page/view/camera_view.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../model/frame_model.dart';
import '../controller/select_frame_controller.dart';

class PhotoboothFrameSelectionPage extends StatefulWidget {
  @override
  PhotoboothFrameSelectionPageState createState() =>
      PhotoboothFrameSelectionPageState();
}

class PhotoboothFrameSelectionPageState
    extends State<PhotoboothFrameSelectionPage> {
  List<FrameModel> images = [];
  String currImage = '';
  int indexCustom = 0;

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    try {
      var temp = await PhotoboothFrameSelectionController().fetchFrames();
      setState(() {
        images = temp;
        // isLoading = false;
      });
    } catch (e) {
      print('Error fetching frames: $e');
      // setState(() {
      // isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Choose A Frame",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),

          backgroundColor: Color(0xFFFFE4E1), // Light green background
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: Color(0xFFFFE4E1), // Light pink tab background
              child: TabBar(
                tabs: [
                  Tab(text: "Default Frames"),
                  Tab(text: "Get From App"),
                ],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.green,
                labelStyle: TextStyle(fontWeight: FontWeight.bold), // Bold for selected label
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Color(0xFFEDF9E4), // Light green background for the body
          child: TabBarView(
            children: [
              // Default Frames Tab
              images.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left grid section
                          Expanded(
                            flex: 3,
                            child: GridView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: images.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currImage = images[index].frameUrl;
                                      indexCustom = images[index].idx;
                                    });
                                  },
                                  child: Image.network(
                                    images[index].frameUrl,
                                    // fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          // Right preview section with select button
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                currImage.isEmpty
                                    ? Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          color: Color(
                                              0xFFFFE4E1), // Light pink color
                                          child: Center(child: Text("Preview")),
                                        ),
                                      )
                                    : Image.network(
                                        currImage,
                                      ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: currImage.isEmpty
                                        ? null
                                        : () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CameraWithTimer(
                                                  currIndex:
                                                      indexCustom,
                                                  frameUrl: currImage,
                                                ), // The page you want to navigate to
                                              ),
                                            );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Color(0xFFFFE4E1),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "Select",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              // Get From App Tab
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: kIsWeb
                                    ? SizedBox(
                                        width: 500,
                                        height: 500,
                                        child: MobileScanner(
                                            allowDuplicates: false,
                                            onDetect: (barcode, args) async {
                                              ViewDialogUtil()
                                                  .showLoadingDialog(context);
                                              FrameModel? temp =
                                                  await PhotoboothFrameSelectionController()
                                                      .fetchFramesURL(
                                                          barcode.rawValue);
                                              setState(() {
                                                currImage =
                                                    temp?.frameUrl ?? currImage;
                                                indexCustom = temp?.idx ?? 0;
                                              });
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                Navigator.of(context).pop();
                                              });

                                              print(barcode.rawValue);
                                            }),
                                      )
                                    : SizedBox.shrink()),
                            SizedBox(height: 20),
                            Text(
                              "Show the code to the camera\nand align it with the scanner",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currImage.isEmpty
                              ? Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    // height: 500,
                                    color:
                                        Color(0xFFFFE4E1), // Light pink color
                                    child: Center(child: Text("Preview")),
                                  ),
                                )
                              : Image.network(
                                  currImage,
                                ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: currImage.isEmpty
                                  ? null
                                  : () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => CameraWithTimer(
                                            currIndex: indexCustom,
                                            frameUrl: currImage,
                                          ), // The page you want to navigate to
                                        ),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Color(0xFFFFE4E1),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Select",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

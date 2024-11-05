import 'package:booth_bliss/view/08_Photobooth_Frame_Page/view/camera_view.dart';
import 'package:booth_bliss/view/Utils/view_dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';

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
  int currIdx = 0;

  @override
  void initState() {
    super.initState();
    loadImages();
    if (images.isNotEmpty) currImage = images[currIdx].frameURl;
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Choose A Frame", style: TextStyle(color: Colors.black)),
          backgroundColor: Color(0xFFEDF9E4), // Light green background
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: Color(0xFFFFF0F5), // Light pink tab background
              child: TabBar(
                tabs: [
                  Tab(text: "Default Frames"),
                  Tab(text: "Get From App"),
                ],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.green,
              ),
            ),
          ),
        ),
        body: Container(
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
                                      currImage = images[index].frameURl;
                                      currIdx = index;
                                    });
                                  },
                                  child: Image.network(
                                    images[index].frameURl,
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  currImage.isEmpty
                                      ? Container(
                                          width: double.infinity,
                                          height: 200,
                                          color: Color(
                                              0xFFFFE4E1), // Light pink color
                                          child: Center(child: Text("Preview")),
                                        )
                                      : Image.network(
                                          currImage,
                                        ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          // builder: (context) => PhotoGridExample(index: currIdx,), // The page you want to navigate to
                                          builder: (context) => CameraWithTimer(
                                            currIndex: images[currIdx].idx,
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
                                    child: Text("Select"),
                                  ),
                                ],
                              ),
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: FlutterWebQrcodeScanner(
                                    height: 300,
                                    width: 300,
                                    onGetResult: (result) async{
                                      ViewDialogUtil().showLoadingDialog(context);
                                      String? temp = await PhotoboothFrameSelectionController().fetchFramesURl(result);
                                      setState(() {
                                        currImage = temp ?? currImage;
                                      });
                                      WidgetsBinding.instance.addPostFrameCallback((_){
                                        Navigator.of(context).pop();
                                      });

                                      print(result);
                                    })),
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
                              ? Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Color(0xFFFFE4E1), // Light pink color
                                  child: Center(child: Text("Preview")),
                                )
                              : Image.network(
                                  currImage,
                                ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  // builder: (context) => PhotoGridExample(index: currIdx,), // The page you want to navigate to
                                  builder: (context) => CameraWithTimer(
                                    currIndex: images[currIdx].idx,
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
                            child: Text("Select"),
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

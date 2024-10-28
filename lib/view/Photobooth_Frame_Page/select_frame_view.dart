import 'package:flutter/material.dart';

class PhotoboothFrameSelectionPage extends StatefulWidget {
  @override
  PhotoboothFrameSelectionPageState createState() => PhotoboothFrameSelectionPageState();
}

class PhotoboothFrameSelectionPageState extends State<PhotoboothFrameSelectionPage>  {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Choose A Frame", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.lightGreenAccent.shade100,
          bottom: TabBar(
            tabs: [
              Tab(text: "Default Frames"),
              Tab(text: "Get From App"),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            // Default Frames Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Left grid section
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey[300],
                          child: Center(child: Text("Frame ${index + 1}")),
                        );
                      },
                    ),
                  ),
                  // Right preview section with select button
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 200,
                          color: Colors.pink.shade100,
                          child: Center(child: Text("Preview")),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Define your select action
                          },
                          child: Text("Select"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.lightGreenAccent.shade100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Get From App Tab
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.pink.shade100,
                    child: Center(
                      child: Icon(
                        Icons.qr_code_scanner,
                        size: 100,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                      "Show the code to the camera\nand align it with the scanner",
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

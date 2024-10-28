import 'package:flutter/material.dart';

class PhotoboothFrameSelectionPage extends StatefulWidget {
  @override
  PhotoboothFrameSelectionPageState createState() =>
      PhotoboothFrameSelectionPageState();
}

class PhotoboothFrameSelectionPageState
    extends State<PhotoboothFrameSelectionPage> {
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left grid section
                    Expanded(
                      flex: 3,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(child: Text("Frame ${index + 1}")),
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
                          Container(
                            width: double.infinity,
                            height: 200,
                            color: Color(0xFFFFE4E1), // Light pink color
                            child: Center(child: Text("Preview")),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Define your select action
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Color(0xFFEDF9E4),
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
              // Get From App Tab
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      color: Color(0xFFFFE4E1), // Light pink for QR box
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
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
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

import 'package:booth_bliss/view/02_Home_Page/image_grid_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final ImageData imageData;

  DetailPage({required this.imageData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Image Section with icons
              Container(
                height: screenHeight * 0.84, // Adjust the height as needed
                child: Stack(
                  children: [
                    Image.network(
                      imageData.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Profile and Buttons Section
              Container(
                height: screenHeight * 0.25,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Color(0xffffe5e5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.07,
                          backgroundImage: NetworkImage(
                            imageData.imageUrl, // Use the selected image URL
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              imageData.creator, // Use the creator's name
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                            // Add some space between the creator's name and the caption
                            SizedBox(height: 1),
                            Text(
                              '#aesthetic',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          imageData.caption, // Use the image's caption
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    // Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FontAwesomeIcons.heart, color: Colors.red),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Use Frame',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Icon(FontAwesomeIcons.shareNodes,
                            color: Colors.grey[700]),
                      ],
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

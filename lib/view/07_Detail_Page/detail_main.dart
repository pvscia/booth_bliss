import 'package:booth_bliss/view/02_Home_Page/image_grid_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final ImageData imageData;

  DetailPage({required this.imageData});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isHeartPressed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    String _getCategoriesString(List<String> categories) {
      return categories.map((category) => '#$category').join(' ');
    }

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
                      widget.imageData.imageUrl,
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
                height: screenHeight * 0.28,
                padding:
                    EdgeInsets.only(top: 20, bottom: 15, left: 20, right: 20),
                color: Color(0xffffe5e5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.07,
                          backgroundImage: NetworkImage(
                            widget.imageData
                                .imageUrl, // Use the selected image URL
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget
                                  .imageData.creator, // Use the creator's name
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              _getCategoriesString(widget.imageData.categories),
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.025),
                    Row(
                      children: [
                        Text(
                          widget.imageData.caption, // Use the image's caption
                          style: TextStyle(
                            fontSize: screenWidth * 0.034,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isHeartPressed = !_isHeartPressed;
                            });
                          },
                          child: Icon(
                            _isHeartPressed
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: _isHeartPressed
                                ? Colors.red
                                : Colors.red, // Change color based on state
                            size: screenWidth * 0.1,
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffb7ed9e),
                              padding: EdgeInsets.symmetric(
                                  vertical: screenWidth * 0.03,
                                  horizontal: screenWidth * 0.15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      color: Color(0xff50c400),
                                      width: screenWidth * 0.008)),
                            ),
                            child: Text(
                              'Use Frame',
                              style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.shareFromSquare,
                          color: Colors.black,
                          size: screenWidth * 0.1,
                        ),
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

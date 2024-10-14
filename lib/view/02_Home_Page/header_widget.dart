import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xffffe5e5),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        height: screenHeight * 0.075, // Adjust the height
        width: screenWidth * 0.97, // Adjust the width
        decoration: BoxDecoration(
          color: Color(0xfff3fde8), // Outer box color
          borderRadius: BorderRadius.circular(50), // Rounded edges
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: screenHeight * 0.055,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Color(0xffffe5e5), // Inner box color
                  borderRadius: BorderRadius.circular(50), // Rounded edges
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Image.asset('assets/logo.png', fit: BoxFit.fitHeight),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: screenHeight * 0.056,
                margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                padding: EdgeInsets.all(8), // Padding inside the border
                decoration: BoxDecoration(
                  color: Color(0xffffe5e5),
                  border: Border.all(
                      color: Color(0xffffe5e5), width: 2), // Box border
                  borderRadius: BorderRadius.circular(50), // Rounded corners
                ),
                child: Row(
                  children: [
                    Icon(Icons.search,
                        color: Colors.black,
                        size: screenHeight * 0.03), // Search Icon
                    SizedBox(
                        width: screenWidth *
                            0.02), // Space between icon and text field
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 3),
                          hintText: 'Search frame', // Placeholder text
                          border: InputBorder.none, // No internal border
                          isDense:
                              true, // Reduces the padding inside the TextField
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Adjust AppBar height
          child: AppBar(
            backgroundColor: Color(0xffffe5e5),
            flexibleSpace: Center(
              child: Container(
                height: 85, // Height of the outer box
                width: 400, // Full width
                decoration: BoxDecoration(
                  color: Color(0xfff3fde8), // Outer box color
                  borderRadius: BorderRadius.circular(50), // Rounded edges
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceEvenly, // Space between inner boxes
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 70, // Inner box height
                        width: 110, // Inner box width
                        decoration: BoxDecoration(
                          color: Color(0xffffe5e5), // Inner box color
                          borderRadius:
                              BorderRadius.circular(50), // Rounded edges
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 0, bottom: 0),
                          child:
                              Image.asset('assets/logo.png', fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8), // Padding inside the border
                        decoration: BoxDecoration(
                          color: Color(0xffffe5e5),
                          border: Border.all(
                              color: Color(0xffffe5e5), width: 2), // Box border
                          borderRadius:
                              BorderRadius.circular(50), // Rounded corners
                        ),
                        height: 70,
                        width: 260, // Adjust width as needed
                        child: Row(
                          children: [
                            Icon(Icons.search,
                                color: Colors.black, size: 38), // Search Icon
                            SizedBox(
                                width: 8), // Space between icon and text field
                            Expanded(
                              child: TextField(
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment:
                        Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'My Designs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Makes the text bold
                        fontSize: 20.0, // Optional: Set the font size
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg'),
                                    width: 144,
                                    height: 250)),
                            Text(
                              'Frame $index',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    })),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment:
                        Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'Popular Frames',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Makes the text bold
                        fontSize: 20.0, // Optional: Set the font size
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(5, (index) {
                      return Container(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg'),
                                    width: 144,
                                    height: 250)),
                            Text(
                              'Frame $index',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ));
                    })),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment:
                        Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'My Designs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Makes the text bold
                        fontSize: 20.0, // Optional: Set the font size
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(5, (index) {
                      return Container(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg'),
                                    width: 144,
                                    height: 250)),
                            Text(
                              'Frame $index',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ));
                    })),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment:
                        Alignment.centerLeft, // Aligns the text to the left
                    child: Text(
                      'Suggested Creators',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Makes the text bold
                        fontSize: 20.0, // Optional: Set the font size
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(5, (index) {
                      return Container(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            Image(
                                image: NetworkImage(
                                    'https://cdn.icon-icons.com/icons2/2643/PNG/512/avatar_female_woman_person_people_white_tone_icon_159360.png'),
                                width: 150,
                                height: 170),
                            Text(
                              'Frame $index',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ));
                    })),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth < 400) {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // Adjust AppBar height
            child: AppBar(
              backgroundColor: Color(0xffffe5e5),
              flexibleSpace: Center(
                child: Container(
                  height: 50, // Height of the outer box
                  width: 350, // Full width
                  decoration: BoxDecoration(
                    color: Color(0xfff3fde8), // Outer box color
                    borderRadius: BorderRadius.circular(50), // Rounded edges
                  ),
                  child: Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceEvenly, // Space between inner boxes
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 40, // Inner box height
                        width: 80, // Inner box width
                        decoration: BoxDecoration(
                          color: Color(0xffffe5e5), // Inner box color
                          borderRadius:
                              BorderRadius.circular(50), // Rounded edges
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 0, bottom: 0),
                          child: Image.asset('assets/logo.png',
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: const EdgeInsets.only(left: 0, right: 10),
                          padding:
                              EdgeInsets.all(8), // Padding inside the border
                          decoration: BoxDecoration(
                            color: Color(0xffffe5e5),
                            border: Border.all(
                                color: Color(0xffffe5e5),
                                width: 2), // Box border
                            borderRadius:
                                BorderRadius.circular(50), // Rounded corners
                          ),
                          height: 40,
                          width: 260, // Adjust width as needed
                          child: Row(
                            children: [
                              Icon(Icons.search,
                                  color: Colors.black, size: 20), // Search Icon
                              SizedBox(
                                  width:
                                      8), // Space between icon and text field
                              Expanded(
                                child: TextField(
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText:
                                        'Search frame', // Placeholder text
                                    border:
                                        InputBorder.none, // No internal border
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
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(screenHeight * 0.09), // Adjust the height
            child: AppBar(
              backgroundColor: Color(0xffffe5e5),
              flexibleSpace: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                            borderRadius:
                                BorderRadius.circular(50), // Rounded edges
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 0, bottom: 0),
                            child: Image.asset('assets/logo.png',
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: screenHeight * 0.055,
                          margin: const EdgeInsets.only(
                              right: 10, top: 5, bottom: 5),
                          padding:
                              EdgeInsets.all(8), // Padding inside the border
                          decoration: BoxDecoration(
                            color: Color(0xffffe5e5),
                            border: Border.all(
                                color: Color(0xffffe5e5),
                                width: 2), // Box border
                            borderRadius:
                                BorderRadius.circular(50), // Rounded corners
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
                                  style:
                                      TextStyle(fontSize: screenHeight * 0.02),
                                  decoration: InputDecoration(
                                    hintText:
                                        'Search frame', // Placeholder text
                                    border:
                                        InputBorder.none, // No internal border
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
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
}

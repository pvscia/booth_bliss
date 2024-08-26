import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: Container(
            color: Colors.green[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 300.0, // Set the width of the text box
                          height: 40.0, // Set the height of the text box
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                            ),
                            onChanged: (value) {
                              // Handle search logic here
                              print('Search query: $value');
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.notifications))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.fit_screen)),
                                ),
                                Text('Icon 1')
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
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
    );
  }
}

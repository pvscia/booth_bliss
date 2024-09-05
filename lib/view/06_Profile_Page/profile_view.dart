import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            SizedBox(height: 10),
            Text(
              'User_Profile_Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Bio profile text',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              '25000 followers · 15000 following',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Edit profile action
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Results'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Created'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Liked'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3 / 5),
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

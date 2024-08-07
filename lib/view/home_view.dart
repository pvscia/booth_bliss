import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          title: Column(children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
                TextButton(onPressed: () {}, child: Text('Saved')),
                TextButton(onPressed: () {}, child: Text('Liked')),
                TextButton(onPressed: () {}, child: Text('Created')),
                IconButton(onPressed: () {}, icon: Icon(Icons.settings))
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.grid_view)),
                IconButton(onPressed: () {}, icon: Icon(Icons.add))
              ],
            )
          ]),
          backgroundColor: Colors.green[100],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Row()],
        ),
      ),
    );
  }
}

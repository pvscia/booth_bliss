import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: Container(
          color: Colors.green[100],
          child: Column(
            children: [
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
              ),
              SizedBox(height: 10), // Adding a SizedBox for spacing
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.grey[300],
                  child: Image.network('https://via.placeholder.com/150',
                      fit: BoxFit.cover),
                );
              }),
        ),
      ),
    );
  }
}

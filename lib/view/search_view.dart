import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
      preferredSize: Size.fromHeight(120.0),
      child: Container(
          color: Colors.green[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
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
                  ],
                ),
                SizedBox(height: 10),

                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      InkWell(
                        child: IconButton(
                            icon: Icon(Icons.filter), onPressed: () {}),
                      ),
                      InkWell(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Option 1')),
                      ),
                      InkWell(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Option 1')),
                      ),
                      InkWell(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Option 1')),
                      ),
                      InkWell(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Option 1')),
                      ),
                      InkWell(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Option 1')),
                      ),
                    ])),

                SizedBox(height: 10), // Adding a SizedBox for spacing
              ],
            ),
          )),
    ));
  }
}

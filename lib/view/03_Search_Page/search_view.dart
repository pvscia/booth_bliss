import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(154.0),
          child: Container(
              color: Colors.green[100],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 30),
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
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                child: Column(children: [
                  SizedBox(
                    height: 16,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3 / 5),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: NetworkImage(
                                'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg'),
                          ));
                    },
                  ),
                ]))));
  }
}

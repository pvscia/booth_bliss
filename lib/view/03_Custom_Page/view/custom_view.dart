import 'package:flutter/material.dart';

import '../../../model/user_model.dart';
import 'frame_edit_view.dart';

class CustomView extends StatelessWidget {
  final UserModel user;
  final List<String> images = [
    'assets/layout_1.jpg',
    'assets/layout_2.jpg',
    'assets/layout_3.jpg',
    'assets/layout_4.jpg',
    'assets/layout_5.jpg',
    'assets/layout_6.jpg',
  ];

  CustomView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink[50],
          elevation: 0,
          title: Text('Choose Frame', style: TextStyle(color: Colors.black)),
          centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2x2 grid
              crossAxisSpacing: 7,
              mainAxisSpacing: 10,
              childAspectRatio: 2/3,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FrameEditorView(idx: index,user: user,))
                  );
                },
                child: Image.asset(
                  images[index],
                  // fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

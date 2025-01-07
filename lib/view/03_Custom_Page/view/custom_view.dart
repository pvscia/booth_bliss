import 'package:flutter/material.dart';

import '../../../model/user_model.dart';
import 'frame_edit_view.dart';

class CustomView extends StatelessWidget {
  final UserModel user;
  final List<String> images = [
    'assets/layout_1.png',
    'assets/layout_2.png',
    'assets/layout_3.png',
    'assets/layout_4.png',
    'assets/layout_5.png',
    'assets/layout_6.png',
  ];

  CustomView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFF3FDE8),
          elevation: 0,
          title: Text('Choose Frame', style: TextStyle(color: Colors.black)),
          centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFF3FDE8)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2x2 grid
                  crossAxisSpacing: 7,
                  // mainAxisSpacing: 10,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xffffe5e5)),
                        child: Image.asset(
                          images[index],
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

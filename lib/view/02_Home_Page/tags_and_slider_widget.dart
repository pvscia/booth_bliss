import 'package:flutter/material.dart';
import 'dart:math';

class TagsAndSliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryButton('Happy'),
          CategoryButton('Sci-fi'),
          CategoryButton('Summer'),
          CategoryButton('HI'),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String category;

  CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final _random = Random();

    return GestureDetector(
      onTap: () {
        // Implement filterImages function here
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(_random.nextInt(256), _random.nextInt(256),
              _random.nextInt(256), _random.nextInt(256)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(category),
      ),
    );
  }
}

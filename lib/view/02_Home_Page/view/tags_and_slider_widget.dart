import 'package:flutter/material.dart';
import 'dart:math';

// The CategoryButton class remains unchanged

class CategoryButton extends StatefulWidget {
  final String category;
  final Function(String, bool) onSelectionChanged;
  final List<String> selectedCategories;

  CategoryButton(
      this.category, this.onSelectionChanged, this.selectedCategories);

  @override
  CategoryButtonState createState() => CategoryButtonState();
}

class CategoryButtonState extends State<CategoryButton> {
  bool isSelected = false;
  late Color buttonColor;

  int _randomBrightnessValue() {
    return 128 + Random().nextInt(128);
  }

  @override
  void initState() {
    super.initState();
    int r = _randomBrightnessValue();
    int g = _randomBrightnessValue();
    int b = _randomBrightnessValue();
    int a = _randomBrightnessValue();

    // Ensure that not all components are 255
    while (r == 255 && g == 255 && b == 255 && a == 255) {
      r = _randomBrightnessValue();
      g = _randomBrightnessValue();
      b = _randomBrightnessValue();
      a = _randomBrightnessValue();
    }

    buttonColor = Color.fromRGBO(r, g, b, a / 255);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelectionChanged(widget.category, isSelected);
      },
      child: Material(
        elevation: isSelected ? 10.0 : 0.0,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.05,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.01),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(16)),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.category,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.017,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:booth_bliss/model/image_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TagsAndSliderWidget extends StatefulWidget {
  final List<ImageModel> images;
  final Function(List<ImageModel>) onFilter;

  TagsAndSliderWidget({required this.images, required this.onFilter});

  @override
  _TagsAndSliderWidgetState createState() => _TagsAndSliderWidgetState();
}

class _TagsAndSliderWidgetState extends State<TagsAndSliderWidget> {
  List<String> selectedCategories = [];

  void onSelectionChanged(String category, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedCategories.add(category.toLowerCase());
      } else {
        selectedCategories.remove(category.toLowerCase());
      }
    });

    // Filter images based on selected categories
    final filteredImages = widget.images.where((image) {
      return selectedCategories.every((category) =>
          image.categories.any((c) => c.toLowerCase() == category));
    }).toList();

    widget.onFilter(filteredImages);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01, horizontal: screenWidth * 0.0007),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryButton('Happy', onSelectionChanged, selectedCategories),
              CategoryButton('Sci-fi', onSelectionChanged, selectedCategories),
              CategoryButton('Summer', onSelectionChanged, selectedCategories),
              CategoryButton('HI', onSelectionChanged, selectedCategories),
              IconButton(
                icon: Icon(Icons.tune),
                onPressed: () {},
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryButton extends StatefulWidget {
  final String category;
  final Function(String, bool) onSelectionChanged;
  final List<String> selectedCategories;

  CategoryButton(
      this.category, this.onSelectionChanged, this.selectedCategories);

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
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

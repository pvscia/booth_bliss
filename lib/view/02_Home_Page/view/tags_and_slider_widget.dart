import 'package:booth_bliss/view/Utils/constant_var.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../../model/image_model.dart';

class TagsAndSliderWidget extends StatefulWidget {
  final List<ImageModel> images;
  final Function(List<ImageModel>) onFilter;

  TagsAndSliderWidget({required this.images, required this.onFilter});

  @override
  TagsAndSliderWidgetState createState() => TagsAndSliderWidgetState();
}

class TagsAndSliderWidgetState extends State<TagsAndSliderWidget> {
  List<String> selectedCategories = [];
  final ConstantVar constantVar = ConstantVar();
  String selectedSortingOption =
      'Newest to Oldest'; // State variable for sorting option

  void onSelectionChanged(String category, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedCategories.add(category.toLowerCase());
      } else {
        selectedCategories.remove(category.toLowerCase());
      }
    });

    _filterAndSortImages();
  }

  void _filterAndSortImages() {
    // Filter images based on selected categories
    List<ImageModel> filteredImages = widget.images.where((image) {
      // If no categories are selected, show all images
      if (selectedCategories.isEmpty) return true;

      // Check if the image belongs to any of the selected categories
      return selectedCategories.any((category) =>
          image.categories.any((c) => c.toLowerCase() == category));
    }).toList();

    // Sort images based on the selected order
    if (selectedSortingOption == 'Newest to Oldest') {
      filteredImages.sort((a, b) => b.date.compareTo(a.date)); // Newest first
    } else if (selectedSortingOption == 'Oldest to Newest') {
      filteredImages.sort((a, b) => a.date.compareTo(b.date)); // Oldest first
    }

    widget.onFilter(filteredImages);
  }

  void _toggleSortingOrder(String newValue) {
    setState(() {
      selectedSortingOption = newValue; // Update sorting option
    });
    _filterAndSortImages(); // Reapply filtering and sorting
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: constantVar.categories.map((category) {
                      return CategoryButton(
                        category,
                        onSelectionChanged,
                        selectedCategories,
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Sorting icon with popup menu
              PopupMenuButton(
                icon: Icon(Icons.tune),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Newest to Oldest'),
                    onTap: () {
                      _toggleSortingOrder('Newest to Oldest');
                    },
                  ),
                  PopupMenuItem(
                    child: Text('Oldest to Newest'),
                    onTap: () {
                      _toggleSortingOrder('Oldest to Newest');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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

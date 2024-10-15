import 'package:flutter/material.dart';
import 'header_widget.dart';
import 'tags_and_slider_widget.dart';
import 'image_grid_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ImageData> images = [
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['happy', 'summer']),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['sci-fi']),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['summer']),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['hi']),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['happy']),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['sci-fi', 'hi']),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['hi', 'happy']),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['summer', 'happy']),
  ];

  List<ImageData> filteredImages = [];

  void onFilter(List<ImageData> filteredImages) {
    setState(() {
      this.filteredImages = filteredImages;
    });
  }

  @override
  void initState() {
    super.initState();
    filteredImages = images;
  }

  void _onSelectionChanged(bool isAnyButtonSelected) {
    // You can add additional logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HeaderWidget(),
            TagsAndSliderWidget(
              images: images,
              onFilter: onFilter,
            ),
            Flexible(flex: 1, child: ImageGridWidget(images: filteredImages)),
          ],
        ),
      ),
    );
  }
}

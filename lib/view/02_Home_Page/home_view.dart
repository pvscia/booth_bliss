import 'package:booth_bliss/view/07_Detail_Page/detail_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
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
        categories: ['happy', 'summer'],
        creator: 'John Doe',
        caption: 'Summer vibes'),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['sci-fi'],
        creator: 'Jane Doe',
        caption: 'Scifi landscape'),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['summer'],
        creator: 'Jumadi',
        caption: 'Summer chilling'),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['hi'],
        creator: 'Abang Ganteng',
        caption: 'Say hi to the world'),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['happy'],
        creator: 'Willy Salim',
        caption: 'Happy Banget Bro'),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['sci-fi', 'hi'],
        creator: 'Alamak Jang',
        caption: 'Say Hi to Scifi lovers'),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['hi', 'happy'],
        creator: 'Bruno Mars',
        caption: 'Happily Say Hi!!'),
    ImageData(
        imageUrl:
            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
        categories: ['summer', 'happy'],
        creator: 'Bu Jumaidah',
        caption: 'Happy Summer Vacation'),
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
        body: Expanded(
          child: Column(
            children: [
              HeaderWidget(),
              TagsAndSliderWidget(
                images: images,
                onFilter: onFilter,
              ),
              Flexible(
                flex: 1,
                child: ImageGridWidget(
                  images: filteredImages,
                  onTap: (image) {
                    Get.to(DetailPage(imageData: image));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:booth_bliss/view/07_Detail_Page/detail_main.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:booth_bliss/view/07_Detail_Page/detail_main.dart';

class ImageData {
  final String imageUrl;
  final List<String> categories;
  final String creator;
  final String caption;

  ImageData(
      {required this.imageUrl,
      required this.categories,
      required this.creator,
      required this.caption});
}

class ImageGridWidget extends StatelessWidget {
  final List<ImageData> images;
  final Function(ImageData) onTap;

  ImageGridWidget({required this.images, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 10),
      childAspectRatio: 0.56,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 15,
      children:
          images.map((image) => ImageItem(image: image, onTap: onTap)).toList(),
    );
  }
}

class ImageItem extends StatelessWidget {
  final ImageData image;
  final Function(ImageData) onTap;

  ImageItem({required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(image);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 170, // Set a fixed width for the image
          height: 300, // Set a fixed height for the image
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

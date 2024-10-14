import 'package:flutter/material.dart';

class ImageData {
  final String imageUrl;
  final List<String> categories;

  ImageData({required this.imageUrl, required this.categories});
}

class ImageGridWidget extends StatelessWidget {
  final List<ImageData> images;

  ImageGridWidget({required this.images});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 10),
      childAspectRatio: 0.56,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 15,
      children: images.map((image) => ImageItem(image)).toList(),
    );
  }
}

class ImageItem extends StatelessWidget {
  final ImageData image;

  ImageItem(this.image);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 170, // Set a fixed width for the image
        height: 300, // Set a fixed height for the image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image.imageUrl),
            fit: BoxFit.cover, // Use BoxFit.cover to maintain aspect ratio
            // errorBuilder: (context, error, stackTrace) {
            //   return Center(
            //     child: Text('Error loading image'),
            //   );
            // },
          ),
        ),
      ),
    );
  }
}

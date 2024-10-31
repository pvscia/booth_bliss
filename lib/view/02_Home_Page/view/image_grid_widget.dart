import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../model/image_model.dart';

class ImageGridWidget extends StatelessWidget {
  final List<ImageModel> images;
  final Function(ImageModel) onTap;

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
  final ImageModel image;
  final Function(ImageModel) onTap;

  ImageItem({required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(image);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 170, // Set a fixed width for the image
          height: 300, // Set a fixed height for the image
          child: CachedNetworkImage(
            imageUrl: image.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

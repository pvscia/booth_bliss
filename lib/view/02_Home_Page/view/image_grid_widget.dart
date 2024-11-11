import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../model/image_model.dart';

class ImageGridWidget extends StatefulWidget {
  final List<ImageModel> images;
  final Function(ImageModel) onTap;

  ImageGridWidget({required this.images, required this.onTap});

  @override
  ImageGridWidgetState createState() => ImageGridWidgetState();
}

class ImageGridWidgetState extends State<ImageGridWidget> {
  bool isLoading = false;
  late ScrollController scrollController;
  late List<ImageModel> data;

  @override
  void initState() {
    super.initState();
    data = widget.images.take(8).toList();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (data.length < widget.images.length) {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !isLoading) {
          setState(() {
            isLoading = true;
          });

          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              var items = widget.images.skip(data.length).take(8);
              data.addAll(items);
              isLoading = false;
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.56,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ImageItem(image: data[index], onTap: widget.onTap);
            },
          ),
          if (isLoading) Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        ],
      ),
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
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ImageGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 10),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 15,
      children: [
        ImageItem('https://placehold.co/170x300', ['happy', 'summer'], 5),
        ImageItem('https://placehold.co/170x300', ['sci-fi'], 3),
        ImageItem('https://placehold.co/170x300', ['summer'], 4),
        ImageItem('https://placehold.co/170x300', ['hi'], 2),
        ImageItem('https://placehold.co/170x300', ['happy'], 3),
        ImageItem('https://placehold.co/170x300', ['sci-fi', 'hi'], 1),
        ImageItem('https://placehold.co/170x300', ['summer', 'happy'], 2),
        ImageItem('https://placehold.co/170x300', ['hi'], 1),
      ],
    );
  }
}

class ImageItem extends StatelessWidget {
  final String imageUrl;
  final List<String> categories;
  final int pictureCount;

  ImageItem(this.imageUrl, this.categories, this.pictureCount);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            // child: Text(
            //   '$pictureCount pictures', // Display the picture count
            //   style: TextStyle(fontSize: 12),
            // ),
          ),
        ),
      ],
    );
  }
}

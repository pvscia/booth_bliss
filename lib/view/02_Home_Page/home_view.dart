import 'package:booth_bliss/model/image_model.dart';
import 'package:booth_bliss/model/user_model.dart';
import 'package:booth_bliss/view/02_Home_Page/view/header_widget.dart';
import 'package:booth_bliss/view/02_Home_Page/view/image_grid_widget.dart';
import 'package:booth_bliss/view/06_Detail_Page/view/detail_main.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'tags_and_slider_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Create user instances
  UserModel user1 = UserModel(
      firstName: 'Gilbert', lastName: 'Smith', email: 'gilbert@example.com');
  UserModel user2 =
      UserModel(firstName: 'Jane', lastName: 'Doe', email: 'jane@example.com');

  List<ImageModel> images = [];
  List<ImageModel> filteredImages = [];

  get onFilter => null;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize images here
  //   images = [
  //     ImageModel(
  //       imageUrl:
  //           'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
  //       desc: 'asdasdasd',
  //       user: user1,
  //       categories: ['happy', 'summer'],
  //     ),
  //     ImageModel(
  //       imageUrl:
  //           'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
  //       desc: 'asfgdg',
  //       user: user2,
  //       categories: ['sci-fi'],
  //     ),
  //     ImageModel(
  //       imageUrl:
  //           'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
  //       desc: 'asdasdasd',
  //       user: user1,
  //       categories: ['summer'],
  //     ),
  //     ImageModel(
  //       imageUrl:
  //           'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
  //       desc: 'asdasdasd',
  //       user: user2,
  //       categories: ['hi'],
  //     ),
  //     ImageModel(
  //       imageUrl:
  //           'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
  //       desc: 'asdasdasd',
  //       user: user1,
  //       categories: ['happy'],
  //     ),
  //     ImageModel(
  //       imageUrl:
  //           'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
  //       desc: 'asdasdasd',
  //       user: user2,
  //       categories: ['sci-fi', 'hi'],
  //     ),
  //     ImageModel(
  //       imageUrl:
  //           'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
  //       desc: 'asdasdasd',
  //       user: user1,
  //       categories: ['hi', 'happy'],
  //     ),
  //     ImageModel(
  //       imageUrl:
  //           'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
  //       desc: 'asdasdasd',
  //       user: user2,
  //       categories: ['summer', 'happy'],
  //     ),
  //   ];

  //   // Initialize filteredImages with all images
  //   filteredImages = images;
  // }

  // void onFilter(List<ImageModel> filteredImages) {
  //   setState(() {
  //     this.filteredImages = filteredImages;
  //   });
  // }

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
    );
  }
}

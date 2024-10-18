import 'package:booth_bliss/view/02_Home_Page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import '../../../model/image_model.dart';
import '../../06_Detail_Page/view/detail_main.dart';
import 'header_widget.dart';
import 'tags_and_slider_widget.dart';
import 'image_grid_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ImageModel> filteredImages = [];
  List<ImageModel> images = [];
  bool isLoading = false;

  void onFilter(List<ImageModel> filteredImages) {
    setState(() {
      this.filteredImages = filteredImages;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFrames();
    filteredImages = images;
  }

  Future<void> _fetchFrames() async {
    setState(() {
      isLoading = true;
    });
    try {
      var temp =  await HomeController().fetchFrames();
      setState(() {
        images = temp;
        filteredImages = images;
        isLoading=false;
      });
    } catch (e) {
      print('Error fetching frames: $e');
      setState(() {
        isLoading=false;
      });
    }
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
            !isLoading ? Flexible(
              flex: 1,
              child: ImageGridWidget(
                images: filteredImages,
                onTap: (image) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DetailPage(imageData: image))
                  );
                },
              ),
            ) : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

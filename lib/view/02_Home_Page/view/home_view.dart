// views/home_view.dart
import 'package:booth_bliss/view/02_Home_Page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import '../../../model/image_model.dart';
import '../../06_Detail_Page/view/detail_main.dart';
import 'header_widget.dart';
import 'tags_and_slider_widget.dart';
import 'image_grid_widget.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  List<ImageModel> filteredImages = [];
  List<ImageModel> images = [];
  bool isLoading = false;
  bool isRefresh = false;
  String searchQuery = '';

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
      var temp = await HomeController().fetchFrames();
      setState(() {
        images = temp;
        filteredImages = images; // Initially show all images
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching frames: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;

      // Filter images based on the search query
      filteredImages = images.where((image) {
        bool matchesDescription =
            image.desc.toLowerCase().contains(query.toLowerCase());
        bool matchesCategory = image.categories.any(
            (category) => category.toLowerCase().contains(query.toLowerCase()));
        bool matchesFirstName = (image.user.firstName?.toLowerCase() ?? '')
            .contains(query.toLowerCase());
        bool matchesLastName = (image.user.lastName?.toLowerCase() ?? '')
            .contains(query.toLowerCase());

        return matchesDescription ||
            matchesCategory ||
            matchesFirstName ||
            matchesLastName;
      }).toList();
    });
  }

  Future<void> refreshPage() async {
    setState(() {
      isRefresh = true;
    });
    List<ImageModel> temp = await HomeController().fetchFrames();
    if (temp.isNotEmpty) {
      setState(() {
        filteredImages = temp;
      });
    }
    setState(() {
      isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: Column(
            children: [
              HeaderWidget(onSearchChanged: updateSearchQuery),
              // Pass the callback
              TagsAndSliderWidget(
                images: images,
                onFilter: onFilter,
              ),
              !isLoading
                  ? Expanded(
                      flex: 1,
                      child: ImageGridWidget(
                        images: filteredImages, // Use filtered images
                        onTap: (image) async {
                          if(!isRefresh){
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(imageData: image),
                              ),
                            );
                            refreshPage();
                          }
                        },
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}

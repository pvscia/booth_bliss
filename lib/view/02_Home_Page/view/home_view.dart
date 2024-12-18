// views/home_view.dart
import 'package:booth_bliss/view/02_Home_Page/controller/home_controller.dart';
import 'package:booth_bliss/view/02_Home_Page/view/tags_and_slider_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../model/image_model.dart';
import '../../06_Detail_Page/view/detail_main.dart';
import '../../Utils/constant_var.dart';
import '../../Utils/view_dialog_util.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  List<ImageModel> filteredImages = [];
  List<ImageModel> images = [];
  bool isLoading = false;
  bool isRefresh = false;
  List<String> selectedCategories = [];
  final ConstantVar constantVar = ConstantVar();
  String selectedSortingOption = 'Newest to Oldest';
  bool isLoadingMore = false;
  late ScrollController scrollController;
  List<ImageModel> data = [];
  TextEditingController etSearch = TextEditingController();

  void onSelectionChanged(String category, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedCategories.add(category.toLowerCase());
      } else {
        selectedCategories.remove(category.toLowerCase());
      }
    });

    _filterAndSortImages();
  }

  void _filterAndSortImages() {
    // Filter images based on selected categories
    List<ImageModel> temp = images.where((image) {
      // If no categories are selected, show all images
      if (selectedCategories.isEmpty) return true;

      // Check if the image belongs to any of the selected categories
      return selectedCategories.every((category) =>
          image.categories.any((c) => c.toLowerCase() == category));
    }).toList();

    // Sort images based on the selected order
    if (selectedSortingOption == 'Newest to Oldest') {
      temp.sort((a, b) => b.date.compareTo(a.date)); // Newest first
    } else if (selectedSortingOption == 'Oldest to Newest') {
      temp.sort((a, b) => a.date.compareTo(b.date)); // Oldest first
    }
    setState(() {
      filteredImages = temp;
      data = filteredImages.take(8).toList();
    });
  }

  void _toggleSortingOrder(String newValue) {
    setState(() {
      selectedSortingOption = newValue; // Update sorting option
    });
    _filterAndSortImages(); // Reapply filtering and sorting
  }

  @override
  void initState() {
    super.initState();
    _fetchFrames();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (data.length < filteredImages.length) {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !isLoadingMore) {
          setState(() {
            isLoadingMore = true;
          });

          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              var items = filteredImages.skip(data.length).take(8);
              data.addAll(items);
              isLoadingMore = false;
            });
          });
        }
      }
    });
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
        data = filteredImages.take(8).toList();
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
      data = filteredImages.take(8).toList();
    });
  }

  Future<void> refreshPage() async {
    bool? isConnect = await ViewDialogUtil.checkConnection();
    if(!isConnect){
      ViewDialogUtil().showNoConnectionDialog(context, (){});
      return;
    }
    setState(() {
      isRefresh = true;
    });
    List<ImageModel> temp = await HomeController().fetchFrames();
    if (temp.isNotEmpty) {
      setState(() {
        images = temp;
      });
    }
    setState(() {
      if (etSearch.text.isNotEmpty) {
        updateSearchQuery(etSearch.text);
      } else {
        filteredImages = images;
      }
      if(selectedCategories.isNotEmpty){
        _filterAndSortImages();
      }
      data = filteredImages.take(8).toList();
      isRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: Column(
            children: [
              Container(
                color: Color(0xffffe5e5),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  height: screenHeight * 0.075,
                  // Adjust the height
                  width: screenWidth * 0.97,
                  // Adjust the width
                  decoration: BoxDecoration(
                    color: Color(0xfff3fde8), // Outer box color
                    borderRadius: BorderRadius.circular(50), // Rounded edges
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: screenHeight * 0.055,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Color(0xffffe5e5), // Inner box color
                            borderRadius:
                                BorderRadius.circular(50), // Rounded edges
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 0, bottom: 0),
                            child: Image.asset('assets/logo.png',
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: screenHeight * 0.056,
                          margin: const EdgeInsets.only(
                              right: 10, top: 5, bottom: 5),
                          padding: EdgeInsets.all(8),
                          // Padding inside the border
                          decoration: BoxDecoration(
                            color: Color(0xffffe5e5),
                            border:
                                Border.all(color: Color(0xffffe5e5), width: 2),
                            // Box border
                            borderRadius:
                                BorderRadius.circular(50), // Rounded corners
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search,
                                  color: Colors.black,
                                  size: screenHeight * 0.03),
                              // Search Icon
                              SizedBox(width: screenWidth * 0.02),
                              // Space between icon and text field
                              Expanded(
                                child: TextField(
                                  controller: etSearch,
                                  onChanged: updateSearchQuery,
                                  // Call the function on text change
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 10, bottom: 3),
                                    hintText: 'Search frame',
                                    // Placeholder text
                                    border: InputBorder.none,
                                    // No internal border
                                    isDense:
                                        true, // Reduces the padding inside the TextField
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Pass the callback
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: constantVar.categories.map((category) {
                                return CategoryButton(
                                  category,
                                  onSelectionChanged,
                                  selectedCategories,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        // Sorting icon with popup menu
                        PopupMenuButton(
                          icon: Icon(Icons.tune),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Newest to Oldest'),
                              onTap: () {
                                _toggleSortingOrder('Newest to Oldest');
                              },
                            ),
                            PopupMenuItem(
                              child: Text('Oldest to Newest'),
                              onTap: () {
                                _toggleSortingOrder('Oldest to Newest');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              !isLoading
                  ? Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.56,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                              ),
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () async {
                                    var image = data[index];
                                    if (!isRefresh) {
                                      var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(imageData: image),
                                        ),
                                      );
                                      if(result=="delete"){
                                        setState(() {
                                          filteredImages.remove(data[index]);
                                          images.remove(data[index]);
                                          data.removeAt(index);
                                        });
                                      }else{
                                        setState(() {
                                          data[index] = result;
                                        });

                                      }
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: SizedBox(
                                      width:
                                          170, // Set a fixed width for the image
                                      height:
                                          300, // Set a fixed height for the image
                                      child: CachedNetworkImage(
                                        imageUrl: data[index].imageUrl,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (isLoadingMore)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
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

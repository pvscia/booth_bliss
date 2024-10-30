import 'package:booth_bliss/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:booth_bliss/model/user_model.dart';

import '../../06_Detail_Page/view/detail_main.dart';
import '../../Utils/view_dialog_util.dart';
import '../controller/profile_controller.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  final UserModel? user;
  final bool? viewOnly;

  const ProfileView({super.key, required this.user, this.viewOnly});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  late UserModel updatedUser;
  String imageUrl = '';
  int selectedIndex = 1;
  bool isLoading = false;
  late bool isViewOnly;
  String selectedSortingOption = 'Newest to Oldest';
  String searchQuery = '';
  List<ImageModel> filteredImages = [];
  List<ImageModel> images = [];

  @override
  void initState() {
    super.initState();
    updatedUser = widget.user!; // Initialize with the passed user data
    isViewOnly = widget.viewOnly ?? false;
    _fetchUserPhoto();
    _fetchUserCreated();
  }

  Future<void> _fetchUserPhoto() async {
    setState(() {
      isLoading = true;
    });
    String? fetchedUrl = '';
    try {
      fetchedUrl = await ProfileController().fetchProfilePhoto(updatedUser.uid);
      setState(() {
        imageUrl = fetchedUrl!;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching photo: $e');
      setState(() {
        imageUrl = '';
        isLoading = false;
      });
    }
  }

  Future<void> _fetchUserResult() async {
    setState(() {
      images = [];
    });
  }

  Future<void> _fetchUserLiked() async {
    setState(() {
      isLoading = true;
    });
    try {
      var temp = await ProfileController().fetchLiked(updatedUser.email ?? '');
      setState(() {
        images = temp;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching photo: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchUserCreated() async {
    setState(() {
      isLoading = true;
    });
    try {
      var temp =
          await ProfileController().fetchCreated(updatedUser.email ?? '');
      setState(() {
        images = temp;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching photo: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _sortImages() {
    if (selectedSortingOption == 'Newest to Oldest') {
      images.sort((a, b) => b.date.compareTo(a.date)); // Newest first
    } else if (selectedSortingOption == 'Oldest to Newest') {
      images.sort((a, b) => a.date.compareTo(b.date)); // Oldest first
    }
  }

  void _toggleSortingOrder(String newValue) {
    setState(() {
      selectedSortingOption = newValue; // Update sorting option
    });
    _sortImages(); // Reapply filtering and sorting
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF3FDE8),
      appBar: AppBar(
        leading: isViewOnly
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF3FDE8),
        elevation: 0,
        actions: [
          if (!isViewOnly)
            IconButton(
              onPressed: () async {
                ViewDialogUtil().showYesNoActionDialog(
                    'Are you sure you want to log out?', 'Yes', 'No', context,
                    () async {
                  await ProfileController().logout();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(context, '/front_page');
                  });
                }, () {});
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          IconButton(
            onPressed: () async {
              ViewDialogUtil().showYesNoActionDialog(
                  'Are you sure you want to log out?', 'Yes', 'No', context,
                  () async {
                await ProfileController().logout();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, '/front_page');
                });
              }, () {});
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),
            CircleAvatar(
              radius: 50,
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl.toString())
                  : AssetImage('assets/default-user.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(
              '${updatedUser.firstName} ${updatedUser.lastName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              updatedUser.bio ?? 'No Bio',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            if (!isViewOnly)
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push<UserModel>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        user: updatedUser,
                      ),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      updatedUser = result; // Update the user data directly
                    });
                    await _fetchUserPhoto();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFAFCC)),
                child: Text('Edit Profile'),
              ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          _fetchUserResult();
                          setState(() {
                            selectedIndex = 0; // Update the selected index
                          });
                        },
                        child: Text(
                          'Results',
                          style: TextStyle(
                              color: selectedIndex == 0
                                  ? Colors.blue
                                  : Colors.black,
                              decoration: selectedIndex == 0
                                  ? TextDecoration.underline
                                  : TextDecoration.none),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _fetchUserCreated();
                          setState(() {
                            selectedIndex = 1; // Update the selected index
                          });
                        },
                        child: Text(
                          'Created',
                          style: TextStyle(
                              color: selectedIndex == 1
                                  ? Colors.blue
                                  : Colors.black,
                              decoration: selectedIndex == 1
                                  ? TextDecoration.underline
                                  : TextDecoration.none),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _fetchUserLiked();
                          setState(() {
                            selectedIndex = 2; // Update the selected index
                          });
                        },
                        child: Text(
                          'Liked',
                          style: TextStyle(
                              color: selectedIndex == 2
                                  ? Colors.blue
                                  : Colors.black,
                              decoration: selectedIndex == 2
                                  ? TextDecoration.underline
                                  : TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffffe5e5),
                      border: Border.all(
                          color: Color(0xffffe5e5), width: 2), // Box border
                      borderRadius:
                          BorderRadius.circular(50), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16), // Adds padding inside the container
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 20, // Search Icon
                        ),
                        SizedBox(
                          width: screenWidth *
                              0.02, // Space between icon and text field
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: updateSearchQuery,
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 10, bottom: 3),
                              hintText: 'Search frame', // Placeholder text
                              border: InputBorder.none, // No internal border
                              isDense:
                                  true, // Reduces the padding inside the TextField
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.tune, size: screenHeight * 0.03),
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
                  SizedBox(
                    height: 20,
                  ),
                  !isLoading
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 3 / 5,
                          ),
                          itemCount: (filteredImages.isNotEmpty
                                  ? filteredImages
                                  : images)
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            final currentImages = filteredImages.isNotEmpty
                                ? filteredImages
                                : images;
                            return GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            imageData: currentImages[index])));
                                if (selectedIndex == 0) {
                                  _fetchUserResult();
                                } else if (selectedIndex == 1) {
                                  _fetchUserCreated();
                                } else if (selectedIndex == 2) {
                                  _fetchUserLiked();
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  currentImages[index].imageUrl,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            );
                          },
                        )
                      : Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

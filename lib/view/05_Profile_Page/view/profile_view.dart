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
  List<ImageModel> images = [];
  bool isLoading = false;
  late bool isViewOnly;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green[100],
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
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
                      if(!isViewOnly)TextButton(
                        onPressed: () {
                          _fetchUserResult();
                          setState(() {
                            selectedIndex = 0; // Update the selected index
                          });
                        },
                        child: Text(
                          'Results',
                          style: TextStyle(
                            color:
                                selectedIndex == 0 ? Colors.blue : Colors.black,
                          ),
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
                            color:
                                selectedIndex == 1 ? Colors.blue : Colors.black,
                          ),
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
                            color:
                                selectedIndex == 2 ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                          itemCount: images.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            imageData: images[index])));
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
                                  images[index].imageUrl,
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

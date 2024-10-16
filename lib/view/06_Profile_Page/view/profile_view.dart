import 'package:booth_bliss/model/image_model.dart';
import 'package:booth_bliss/view/06_Profile_Page/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:booth_bliss/model/user_model.dart';
import 'package:booth_bliss/view/06_Profile_Page/view/edit_profile_view.dart';

import '../../Utils/view_dialog_util.dart';

class ProfileView extends StatefulWidget {
  final UserModel? user;

  const ProfileView({super.key, required this.user});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  late UserModel updatedUser;
  String imageUrl = '';
  int selectedIndex = 1;
  List<ImageModel> images =[];
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    updatedUser = widget.user!; // Initialize with the passed user data
    _fetchUserPhoto();
    _fetchUserCreated();
  }

  Future<void> _fetchUserPhoto() async {
    setState(() {
      isLoading = true;
    });
    String? fetchedUrl = '';
    try {
      fetchedUrl = await ProfileController().fetchPhoto(updatedUser.uid);
      setState(() {
        imageUrl = fetchedUrl!;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching photo: $e');
      setState(() {
        imageUrl = '';
        isLoading=false;
      });
    }
  }

  Future<void> _fetchUserResult() async {
    setState(() {
      images=[];
    });
  }

  Future<void> _fetchUserLiked() async {
    setState(() {
      images=[];
    });
  }

  Future<void> _fetchUserCreated() async {
    setState(() {
      isLoading = true;
    });
    try {
      var temp = await ProfileController().fetchCreated(updatedUser.email ?? '');
      setState(() {
        images = temp;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching photo: $e');
      setState(() {
        isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green[100],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              ViewDialogUtil().showYesNoActionDialog(
                  'Are you sure you want to log out?',
                  'Yes',
                  'No',
                  context,
                      () async {
                        await ProfileController().logout();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushReplacementNamed(context, '/front_page');
                        });
                  },
                      (){});
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
                            color: selectedIndex == 0 ? Colors.blue : Colors.black,
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
                            color: selectedIndex == 1 ? Colors.blue : Colors.black,
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
                            color: selectedIndex == 2 ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  !isLoading ? GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3 / 5,
                    ),
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          images[index].imageUrl,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ) : Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

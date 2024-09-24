import 'package:booth_bliss/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:booth_bliss/model/user_model.dart';
import 'package:booth_bliss/view/06_Profile_Page/edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  final UserModel user;

  const ProfileView({super.key, required this.user});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  late UserModel updatedUser;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    updatedUser = widget.user; // Initialize with the passed user data
    _fetchUserPhoto();
  }

  Future<void> _fetchUserPhoto() async {
    try {
      String? fetchedUrl =
          await ProfileController().fetchPhoto(updatedUser.uid);
      setState(() {
        imageUrl = fetchedUrl!;
      });
    } catch (e) {
      print('Error fetching photo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('isNotEmpty ${imageUrl.isNotEmpty}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green[100],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await ProfileController().logout();
              Navigator.pushReplacementNamed(context, '/front_page');
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
                  : AssetImage('lib/assets/default-user.png') as ImageProvider,
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
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
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
                        onPressed: () {},
                        child: Text('Results'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Created'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Liked'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 8,
                      childAspectRatio: 3 / 5,
                    ),
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://i.pinimg.com/564x/a9/08/92/a90892abfe20695d601263160cbd234f.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

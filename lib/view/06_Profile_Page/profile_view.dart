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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: widget.user.profilePicture.fileloc.isNotEmpty
                  ? NetworkImage(widget.user.profilePicture.fileloc)
                  : AssetImage('lib/assets/logo.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(
              '${widget.user.firstName} ${widget.user.lastName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              widget.user.bio.isNotEmpty ? widget.user.bio : 'No Bio',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      currentBio: widget.user.bio,
                      profilePicUrl: widget.user.profilePicture.fileloc,
                      mUser: widget.user,
                    ),
                  ),
                );
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

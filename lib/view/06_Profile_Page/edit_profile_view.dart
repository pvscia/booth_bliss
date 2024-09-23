import 'package:booth_bliss/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:booth_bliss/controller/edit_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  final String? currentBio;
  final String? profilePicUrl;
  final UserModel mUser;

  EditProfilePage({
    this.currentBio,
    this.profilePicUrl,
    required this.mUser,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileController _controller = EditProfileController();
  final TextEditingController _bioController = TextEditingController();
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _bioController.text = widget.currentBio ?? '';
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    setState(() {
      isSaving = true;
    });

    try {
      var updatedProfile =
          await _controller.saveProfile(_bioController.text, widget.mUser);
      setState(() {
        isSaving = false;
      });
      Navigator.pop(context, updatedProfile);
    } catch (e) {
      setState(() {
        isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: isSaving ? null : _handleSave,
            child: Text(
              'Save',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await _controller.pickImage();
                setState(() {}); // To show the selected image
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _controller.profileImage != null
                    ? FileImage(_controller.profileImage!)
                    : (widget.profilePicUrl != null &&
                            widget.profilePicUrl!.isNotEmpty)
                        ? NetworkImage(widget.profilePicUrl!)
                        : AssetImage('lib/assets/logo.png') as ImageProvider,
                child: Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
                hintText: 'Enter your bio',
              ),
            ),
            SizedBox(height: 20),
            if (isSaving)
              CircularProgressIndicator(), // Show loading indicator while saving
          ],
        ),
      ),
    );
  }
}

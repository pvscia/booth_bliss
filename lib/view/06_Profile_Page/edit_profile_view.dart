import 'package:booth_bliss/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:booth_bliss/controller/edit_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  late final UserModel user;

  EditProfilePage({
    super.key,
    required this.user,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileController _controller = EditProfileController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool isValid = false;
  bool isSaving = false;
  late UserModel mUser;

  @override
  void initState() {
    super.initState();
    mUser = widget.user;
    if (mUser.profilePicture != null) {
      _controller.initImageController(mUser.profilePicture!.fileloc);
    }
    _firstNameController.text = mUser.firstName ?? '';
    _lastNameController.text = mUser.lastName ?? '';
    _bioController.text = mUser.bio ?? '';
    activeInactiveButton();

    _firstNameController.addListener(() {
      activeInactiveButton();
    });

    _lastNameController.addListener(() {
      activeInactiveButton();
    });
  }

  void activeInactiveButton() {
    if (_firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    setState(() {
      isSaving = true;
    });

    try {
      var updatedProfile = await _controller.saveProfile(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          bio: _bioController.text,
          mUser: mUser);
      setState(() {
        isSaving = false;
      });
      isValid ? Navigator.pop(context, updatedProfile) : null;
    } catch (e) {
      setState(() {
        isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile: ${e.toString()}')),
      );
    }
  }

  Future<void> _removeProfile() async {
    setState(() {
      isSaving = true;
    });

    try {
      setState(() {
        _controller.removeProfile(mUser);
        isSaving = false;
      });
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
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            print('wow');
          },
        ),
        actions: [
          TextButton(
            onPressed: isSaving ? null : _handleSave,
            child: Text(
              'Save',
              style: TextStyle(color: isValid ? Colors.black : Colors.grey),
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
                    : (mUser.profilePicture!.fileloc != null &&
                            mUser.profilePicture!.fileloc!.isNotEmpty)
                        ? NetworkImage(mUser.profilePicture!.fileloc!)
                        : const AssetImage('lib/assets/default-user.png')
                            as ImageProvider,
                child: const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: isSaving ? null : _removeProfile,
              child: Text(
                'Remove photo',
                style: TextStyle(
                    color: _controller.profileImage != null
                        ? Colors.red
                        : Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _firstNameController,
              minLines: 1,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
                hintText: 'Enter your first name',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _lastNameController,
              minLines: 1,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
                hintText: 'Enter your last name',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _bioController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
                hintText: 'Enter your bio',
              ),
            ),
            const SizedBox(height: 20),
            if (isSaving)
              const CircularProgressIndicator(), // Show loading indicator while saving
          ],
        ),
      ),
    );
  }
}

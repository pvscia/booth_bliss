import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  File? _image;
  final _picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> categories = ["Happy", "Excited", "Adventure", "Calm"];
  List<String> selectedCategories = [];
  bool isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _postImage() async {
    if (_image == null || _descriptionController.text.isEmpty || selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please complete all fields and select an image.'),
      ));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Generate unique file name for the image
      String fileName = Uuid().v4();
      User? user = FirebaseAuth.instance.currentUser;

      // Upload the image to Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('frames/$fileName.png');
      await storageReference.putFile(_image!);

      // Get the download URL
      String imageUrl = await storageReference.getDownloadURL();

      // Save post details in Firestore
      await FirebaseFirestore.instance.collection('posts').add({
        'userEmail': user?.email,
        'description': _descriptionController.text,
        'categories': selectedCategories,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Post uploaded successfully!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload post: $e'),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: isLoading ? null : _postImage,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _image == null
                    ? Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(Icons.add_photo_alternate, size: 100),
                )
                    : Image.file(_image!),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 16),
              Text('Add Category:', style: TextStyle(fontSize: 16)),
              GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  String category = categories[index];
                  bool isSelected = selectedCategories.contains(category);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCategories.remove(category);
                        } else {
                          selectedCategories.add(category);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(category,
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black)),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: isLoading ? null : _postImage,
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

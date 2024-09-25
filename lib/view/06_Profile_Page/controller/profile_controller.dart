import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> fetchPhoto(String? uid) async {
    String imagePath = 'profilePics/$uid.png';
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booth_bliss/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  Future<UserModel?> login(String email, String password) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.length == 1) {
        // Parse the Firestore document to a UserModel
        DocumentSnapshot document = documents[0];
        UserModel user = UserModel.fromDocument(
          document.data() as Map<String, dynamic>,
          document.id,
        );

        // Save current user to local storage (session)
        await _saveCurrentUser(user);

        return user; // Return the user model
      } else {
        return null; // Invalid login
      }
    } catch (e) {
      throw 'An error occurred during login: $e';
    }
  }

  // Save the logged-in user's data to SharedPreferences
  Future<void> _saveCurrentUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', user.firstName);
    await prefs.setString('lastName', user.lastName);
    await prefs.setString('email', user.email);
  }

  // Load the current user from SharedPreferences
  Future<UserModel?> loadCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? firstName = prefs.getString('firstName');
    String? lastName = prefs.getString('lastName');
    String? email = prefs.getString('email');

    if (firstName != null &&
        lastName != null &&
        email != null) {
      return UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
    }
    return null;
  }

  // Clear the current user session (for logging out)
  Future<void> clearCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

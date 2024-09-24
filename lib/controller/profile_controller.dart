import 'package:firebase_auth/firebase_auth.dart';

class ProfileController{
  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
  }
}
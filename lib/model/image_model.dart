import 'package:booth_bliss/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  String imageUrl;
  String desc;
  List<String> categories;
  UserModel user;
  DateTime date;

  ImageModel(
      {required this.imageUrl,
      required this.desc,
      required this.categories,
      required this.user,
      required this.date});

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'desc': desc,
      'categories': categories,
      'user': user,
      'date': Timestamp.now()
    };
  }
}

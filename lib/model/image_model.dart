import 'package:booth_bliss/model/user_model.dart';

class ImageModel{
  String imageUrl;
  String desc;
  List<String> categories;
  UserModel user;
  ImageModel({
    required this.imageUrl,
    required this.desc,
    required this.categories,
    required this.user});
}
import 'package:booth_bliss/model/user_model.dart';

class ImageModel {
  String imageUrl;
  String filename;
  String docName;
  String desc;
  List<String> categories;
  UserModel user;
  DateTime date;
  List<String> likedBy;

  ImageModel(
      {required this.imageUrl,
      required this.docName,
      required this.filename,
      required this.desc,
      required this.categories,
      required this.user,
      required this.likedBy,
      required this.date});

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'docName': docName,
      'filename': filename,
      'desc': desc,
      'categories': categories,
      'user': user,
      'likedBy': likedBy,
      'date': date
    };
  }
}

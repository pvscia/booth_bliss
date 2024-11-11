class PhotoModel {
  String imageUrl;
  String filename;
  String email;
  DateTime date;

  PhotoModel(
      {required this.imageUrl,
      required this.filename,
      required this.email,
      required this.date});

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'filename': filename,
      'email': email,
      'date': date,
    };
  }
}

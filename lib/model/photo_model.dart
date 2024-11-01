class PhotoModel{
  String imageUrl;
  String filename;
  String email;

  PhotoModel(
      {required this.imageUrl,
        required this.filename,
        required this.email});

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'filename': filename,
      'email': email,
    };
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? bio;
  final DateTime? createdAt;
  final ProfilePictureModel? profilePicture;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.bio,
    this.createdAt,
    this.profilePicture,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      createdAt: (json['created_at'] as Timestamp).toDate(),
      profilePicture: ProfilePictureModel.fromJson(json['profile_pict'] ?? {}),
    );
  }

  // Method to convert UserModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'bio': bio,
      'created_at': createdAt,
      'profile_pict': profilePicture?.toJson(),
    };
  }
}

class ProfilePictureModel {
  final String? filename;
  late final String? fileloc;

  ProfilePictureModel({
     this.filename,
     this.fileloc,
  });

  // Factory method to create ProfilePictureModel from JSON
  factory ProfilePictureModel.fromJson(Map<String, dynamic> json) {
    return ProfilePictureModel(
      filename: json['filename'] ?? '',
      fileloc: json['fileloc'] ?? '',
    );
  }

  // Method to convert ProfilePictureModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'fileloc': fileloc,
    };
  }
}

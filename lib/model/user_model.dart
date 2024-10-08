import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? bio;
  final String? uid;
  final DateTime? createdAt;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.bio,
    this.uid,
    this.createdAt,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      uid: json['uid'] ?? '',
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  // Method to convert UserModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'bio': bio,
      'uid': uid,
      'created_at': createdAt,
    };
  }
}

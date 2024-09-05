class UserModel {
  final String firstName;
  final String lastName;
  final String email;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  // Convert a Firestore document snapshot into a UserModel instance
  factory UserModel.fromDocument(Map<String, dynamic> doc, String docId) {
    return UserModel(
      firstName: doc['first_name'],
      lastName: doc['last_name'],
      email: doc['email'],
    );
  }

  // Convert a UserModel instance into a Map to save in Firestore
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}

class SuggestedUserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final String username;

  SuggestedUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.username,
  });

  String get fullName => '$firstName $lastName';

  factory SuggestedUserModel.fromJson(Map<String, dynamic> json) {
    return SuggestedUserModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'username': username,
    };
  }
}

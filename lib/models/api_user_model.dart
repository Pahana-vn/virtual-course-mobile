class ApiUserModel {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final bool verifiedPhone;
  final String statusStudent;

  ApiUserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.verifiedPhone,
    required this.statusStudent,
  });

  factory ApiUserModel.fromJson(Map<String, dynamic> json) {
    return ApiUserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      verifiedPhone: json['verifiedPhone'] ?? false,
      statusStudent: json['statusStudent'] ?? "INACTIVE",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'verifiedPhone': verifiedPhone,
      'statusStudent': statusStudent,
    };
  }
}

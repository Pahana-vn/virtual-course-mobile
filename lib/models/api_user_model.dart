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

  // Chuyển từ JSON sang ApiUserModel
  factory ApiUserModel.fromJson(Map<String, dynamic> json) {
    return ApiUserModel(
      id: json['id'],
      username: json['username'], // ✅ API trả về "username"
      email: json['email'],
      firstName: json['firstName'] ?? "", // ✅ API có "firstName"
      lastName: json['lastName'] ?? "", // ✅ API có "lastName"
      verifiedPhone: json['verifiedPhone'] ?? false, // ✅ API có "verifiedPhone"
      statusStudent: json['statusStudent'] ?? "INACTIVE", // ✅ API có "statusStudent"
    );
  }

  // Chuyển từ ApiUserModel thành JSON (nếu cần gửi API)
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

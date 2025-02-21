// models/instructor_dto.dart

class InstructorDTO {
  final int id;
  final String firstName;
  final String lastName;
  final String? gender;
  final String? address;
  final String? phone;
  final bool? verifiedPhone;
  final String? bio;
  final String? title;
  final String? photo;
  final String? workplace;
  final String? accountUsername;
  final String? accountEmail;

  InstructorDTO({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.gender,
    this.address,
    this.phone,
    this.verifiedPhone,
    this.bio,
    this.title,
    this.photo,
    this.workplace,
    this.accountUsername,
    this.accountEmail,
  });

  // Chuyển từ JSON sang InstructorDTO
  factory InstructorDTO.fromJson(Map<String, dynamic> json) {
    return InstructorDTO(
      id: json['id'] as int,
      firstName: json['firstName'] ?? "", // Đảm bảo không null
      lastName: json['lastName'] ?? "", // Đảm bảo không null
      gender: json['gender'], // Có thể null
      address: json['address'], // Có thể null
      phone: json['phone'], // Có thể null
      verifiedPhone: json['verifiedPhone'] ?? false, // Nếu null, mặc định là false
      bio: json['bio'], // Có thể null
      title: json['title'], // Có thể null
      photo: json['photo'], // Có thể null
      workplace: json['workplace'], // Có thể null
      accountUsername: json['accountUsername'], // Có thể null
      accountEmail: json['accountEmail'], // Có thể null
    );
  }

  // Chuyển từ InstructorDTO thành JSON (nếu cần gửi API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'address': address,
      'phone': phone,
      'verifiedPhone': verifiedPhone,
      'bio': bio,
      'title': title,
      'photo': photo,
      'workplace': workplace,
      'accountUsername': accountUsername,
      'accountEmail': accountEmail,
    };
  }
}

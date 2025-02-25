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

  factory InstructorDTO.fromJson(Map<String, dynamic> json) {
    return InstructorDTO(
      id: json['id'] as int,
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      gender: json['gender'],
      address: json['address'],
      phone: json['phone'],
      verifiedPhone: json['verifiedPhone'] ?? false,
      bio: json['bio'],
      title: json['title'],
      photo: json['photo'],
      workplace: json['workplace'],
      accountUsername: json['accountUsername'],
      accountEmail: json['accountEmail'],
    );
  }

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

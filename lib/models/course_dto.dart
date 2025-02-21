class CourseDTO {
  final int id;
  final String titleCourse;
  final String description;
  final String categoryName;
  final String imageCover;
  final String? urlVideo;
  final String instructorFirstName;
  final String instructorLastName;

  CourseDTO({
    required this.id,
    required this.titleCourse,
    required this.description,
    required this.categoryName,
    required this.imageCover,
    required this.instructorFirstName,
    required this.instructorLastName,
    this.urlVideo,
  });

  factory CourseDTO.fromJson(Map<String, dynamic> json) {
    return CourseDTO(
      id: json['id'] as int,
      titleCourse: json['titleCourse'] ?? "",
      description: json['description'] ?? "",
      categoryName: json['categoryName'] ?? "",
      imageCover: json['imageCover'] ?? "",
      instructorFirstName: json['instructorFirstName'] ?? "",
      instructorLastName: json['instructorLastName'] ?? "",
      urlVideo: json['urlVideo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleCourse': titleCourse,
      'description': description,
      'categoryName': categoryName,
      'imageCover': imageCover,
      'instructorFirstName': instructorFirstName,
      'instructorLastName': instructorLastName,
      'urlVideo': urlVideo,
    };
  }
}

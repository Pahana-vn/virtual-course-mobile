class CourseDTO {
  final int id;
  final String titleCourse;
  final String description;
  final int categoryId;
  final String categoryName;
  final String level;
  final String imageCover;
  final String? urlVideo;
  final String hashtag;
  final int duration;
  final double basePrice;
  final String status;
  final int progress;
  final String instructorPhoto;
  final String instructorFirstName;
  final String instructorLastName;
  final int instructorId;

  CourseDTO({
    required this.id,
    required this.titleCourse,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.level,
    required this.imageCover,
    required this.hashtag,
    required this.duration,
    required this.basePrice,
    required this.status,
    required this.progress,
    required this.instructorPhoto,
    required this.instructorFirstName,
    required this.instructorLastName,
    required this.instructorId,
    this.urlVideo,
  });

  factory CourseDTO.fromJson(Map<String, dynamic> json) {
    return CourseDTO(
      id: json['id'] as int,
      titleCourse: json['titleCourse'] ?? "",
      description: json['description'] ?? "",
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? "",
      level: json['level'] ?? "UNKNOWN",
      imageCover: json['imageCover'] ?? "",
      urlVideo: json['urlVideo'],
      hashtag: json['hashtag'] ?? "",
      duration: json['duration'] ?? 0,
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? "UNKNOWN",
      progress: json['progress'] ?? 0,
      instructorPhoto: json['instructorPhoto'] ?? "",
      instructorFirstName: json['instructorFirstName'] ?? "",
      instructorLastName: json['instructorLastName'] ?? "",
      instructorId: json['instructorId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleCourse': titleCourse,
      'description': description,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'level': level,
      'imageCover': imageCover,
      'urlVideo': urlVideo,
      'hashtag': hashtag,
      'duration': duration,
      'basePrice': basePrice,
      'status': status,
      'progress': progress,
      'instructorPhoto': instructorPhoto,
      'instructorFirstName': instructorFirstName,
      'instructorLastName': instructorLastName,
      'instructorId': instructorId,
    };
  }
}
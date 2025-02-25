import 'section_dto.dart';

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
  final List<SectionDTO> sections;
  final int? finalTestId;
  final bool allLecturesCompleted;

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
    required this.sections,
    this.urlVideo,
    this.finalTestId,
    required this.allLecturesCompleted,
  });

  factory CourseDTO.fromJson(Map<String, dynamic> json) {
    return CourseDTO(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      titleCourse: json['titleCourse'] ?? "",
      description: json['description'] ?? "",
      categoryId: json['categoryId'] is int ? json['categoryId'] : int.tryParse(json['categoryId'].toString()) ?? 0,
      categoryName: json['categoryName'] ?? "",
      level: json['level'] ?? "UNKNOWN",
      imageCover: json['imageCover'] ?? "",
      urlVideo: json['urlVideo'],
      hashtag: json['hashtag'] ?? "",
      duration: json['duration'] is int ? json['duration'] : int.tryParse(json['duration'].toString()) ?? 0,
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? "UNKNOWN",
      progress: json['progress'] is int ? json['progress'] : int.tryParse(json['progress'].toString()) ?? 0,
      instructorPhoto: json['instructorPhoto'] ?? "",
      instructorFirstName: json['instructorFirstName'] ?? "",
      instructorLastName: json['instructorLastName'] ?? "",
      instructorId: json['instructorId'] is int ? json['instructorId'] : int.tryParse(json['instructorId'].toString()) ?? 0,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((section) => SectionDTO.fromJson(section))
          .toList() ?? [],
      finalTestId: json['finalTestId'] is int ? json['finalTestId'] : int.tryParse(json['finalTestId']?.toString() ?? ""),
      allLecturesCompleted: json['allLecturesCompleted'] ?? false,
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
      'sections': sections.map((section) => section.toJson()).toList(),
      'finalTestId': finalTestId,
      'allLecturesCompleted': allLecturesCompleted,
    };
  }
}

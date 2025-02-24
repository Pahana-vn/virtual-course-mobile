import 'lecture_dto.dart';

class SectionDTO {
  final int id;
  final String titleSection;
  final int numOfLectures;
  final int sessionDuration;
  final int sequenceNumber;
  final int courseId;
  final List<LectureDTO> lectures;

  SectionDTO({
    required this.id,
    required this.titleSection,
    required this.numOfLectures,
    required this.sessionDuration,
    required this.sequenceNumber,
    required this.courseId,
    required this.lectures,
  });

  factory SectionDTO.fromJson(Map<String, dynamic> json) {
    return SectionDTO(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      titleSection: json['titleSection'] ?? "",
      numOfLectures: json['numOfLectures'] is int ? json['numOfLectures'] : int.tryParse(json['numOfLectures'].toString()) ?? 0,
      sessionDuration: json['sessionDuration'] is int ? json['sessionDuration'] : int.tryParse(json['sessionDuration'].toString()) ?? 0,
      sequenceNumber: json['sequenceNumber'] is int ? json['sequenceNumber'] : int.tryParse(json['sequenceNumber'].toString()) ?? 0,
      courseId: json['courseId'] is int ? json['courseId'] : int.tryParse(json['courseId'].toString()) ?? 0,
      lectures: (json['lectures'] as List<dynamic>?)
          ?.map((lecture) => LectureDTO.fromJson(lecture))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleSection': titleSection,
      'numOfLectures': numOfLectures,
      'sessionDuration': sessionDuration,
      'sequenceNumber': sequenceNumber,
      'courseId': courseId,
      'lectures': lectures.map((lecture) => lecture.toJson()).toList(),
    };
  }
}

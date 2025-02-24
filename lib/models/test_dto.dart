import 'question_dto.dart';

class TestDTO {
  final int id;
  final String title;
  final String? description;
  final int totalMarks;
  final int passPercentage;
  final int duration;
  final bool? isFinalTest;
  final String? statusTest;
  final int courseId;
  final int instructorId;
  final List<QuestionDTO> questions;

  TestDTO({
    required this.id,
    required this.title,
    this.description,
    required this.totalMarks,
    required this.passPercentage,
    required this.duration,
    this.isFinalTest,
    this.statusTest,
    required this.courseId,
    required this.instructorId,
    required this.questions,
  });

  factory TestDTO.fromJson(Map<String, dynamic> json) {
    return TestDTO(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? "",
      description: json['description'],
      totalMarks: json['totalMarks'] is int ? json['totalMarks'] : int.tryParse(json['totalMarks'].toString()) ?? 1,
      passPercentage: json['passPercentage'] is int ? json['passPercentage'] : int.tryParse(json['passPercentage'].toString()) ?? 1,
      duration: json['duration'] is int ? json['duration'] : int.tryParse(json['duration'].toString()) ?? 1,
      isFinalTest: json['isFinalTest'],
      statusTest: json['statusTest'],
      courseId: json['courseId'] is int ? json['courseId'] : int.tryParse(json['courseId'].toString()) ?? 0,
      instructorId: json['instructorId'] is int ? json['instructorId'] : int.tryParse(json['instructorId'].toString()) ?? 0,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((question) => QuestionDTO.fromJson(question))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'totalMarks': totalMarks,
      'passPercentage': passPercentage,
      'duration': duration,
      'isFinalTest': isFinalTest,
      'statusTest': statusTest,
      'courseId': courseId,
      'instructorId': instructorId,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}

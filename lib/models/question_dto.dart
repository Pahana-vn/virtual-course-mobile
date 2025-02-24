import 'answer_option_dto.dart';

class QuestionDTO {
  final int id;
  final String content;
  final String type;
  final int marks;
  final int courseId;
  final List<AnswerOptionDTO> answerOptions;
  final String? givenAnswer;
  final String? correctAnswer;
  final bool? isCorrect;

  QuestionDTO({
    required this.id,
    required this.content,
    required this.type,
    required this.marks,
    required this.courseId,
    required this.answerOptions,
    this.givenAnswer,
    this.correctAnswer,
    this.isCorrect,
  });

  factory QuestionDTO.fromJson(Map<String, dynamic> json) {
    return QuestionDTO(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      content: json['content'] ?? "",
      type: json['type'] ?? "UNKNOWN",
      marks: json['marks'] is int ? json['marks'] : int.tryParse(json['marks'].toString()) ?? 0,
      courseId: json['courseId'] is int ? json['courseId'] : int.tryParse(json['courseId'].toString()) ?? 0,
      answerOptions: (json['answerOptions'] as List<dynamic>?)
          ?.map((answer) => AnswerOptionDTO.fromJson(answer))
          .toList() ??
          [],
      givenAnswer: json['givenAnswer'],
      correctAnswer: json['correctAnswer'],
      isCorrect: json['isCorrect'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type,
      'marks': marks,
      'courseId': courseId,
      'answerOptions': answerOptions.map((answer) => answer.toJson()).toList(),
      'givenAnswer': givenAnswer,
      'correctAnswer': correctAnswer,
      'isCorrect': isCorrect,
    };
  }
}

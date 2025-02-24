class AnswerOptionDTO {
  final int id;
  final String content;
  final bool isCorrect;
  final int questionId;

  AnswerOptionDTO({
    required this.id,
    required this.content,
    required this.isCorrect,
    required this.questionId,
  });

  factory AnswerOptionDTO.fromJson(Map<String, dynamic> json) {
    return AnswerOptionDTO(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      content: json['content'] ?? "",
      isCorrect: json['isCorrect'] ?? false,
      questionId: json['questionId'] is int ? json['questionId'] : int.tryParse(json['questionId'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'isCorrect': isCorrect,
      'questionId': questionId,
    };
  }
}

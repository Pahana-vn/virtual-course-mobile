class TestSubmissionDTO {
  final int testId;
  final int studentId;
  final List<StudentAnswerDTO> answers;

  TestSubmissionDTO({
    required this.testId,
    required this.studentId,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      "testId": testId,
      "studentId": studentId,
      "answers": answers.map((e) => e.toJson()).toList(),
    };
  }
}

class StudentAnswerDTO {
  final int questionId;
  final List<int> selectedOptionIds;

  StudentAnswerDTO({
    required this.questionId,
    required this.selectedOptionIds,
  });

  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "selectedOptionIds": selectedOptionIds,
    };
  }
}

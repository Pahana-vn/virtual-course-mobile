import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question_dto.dart';
import '../services/api_question_service.dart';

/// Provider cho `ApiQuizService`
final apiQuizServiceProvider = Provider<ApiQuizService>((ref) {
  return ApiQuizService();
});

/// Provider để lấy danh sách câu hỏi của bài kiểm tra
final questionsByTestProvider = FutureProvider.family<List<QuestionDTO>, int>((ref, testId) async {
  final apiService = ref.watch(apiQuizServiceProvider);
  return await apiService.fetchQuestionsByTest(testId);
});
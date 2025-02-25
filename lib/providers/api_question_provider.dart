import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question_dto.dart';
import '../services/api_question_service.dart';

final apiQuizServiceProvider = Provider<ApiQuizService>((ref) {
  return ApiQuizService();
});

final questionsByTestProvider = FutureProvider.family<List<QuestionDTO>, int>((ref, testId) async {
  final apiService = ref.watch(apiQuizServiceProvider);
  return await apiService.fetchQuestionsByTest(testId);
});
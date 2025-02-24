import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/test_submission_dto.dart';
import '../services/api_test_service.dart';

/// Provider cho `ApiTestService`
final apiTestServiceProvider = Provider<ApiTestService>((ref) {
  return ApiTestService();
});

/// Provider để xử lý nộp bài kiểm tra
final testSubmissionProvider =
FutureProvider.family<Map<String, dynamic>, TestSubmissionDTO>((ref, submission) async {
  final apiService = ref.watch(apiTestServiceProvider);
  return await apiService.submitTest(submission);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/test_submission_dto.dart';
import '../services/api_test_service.dart';

final apiTestServiceProvider = Provider<ApiTestService>((ref) {
  return ApiTestService();
});

final testSubmissionProvider =
FutureProvider.family<Map<String, dynamic>, TestSubmissionDTO>((ref, submission) async {
  final apiService = ref.watch(apiTestServiceProvider);
  return await apiService.submitTest(submission);
});

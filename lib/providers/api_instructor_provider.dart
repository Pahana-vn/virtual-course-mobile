// providers/api_instructor_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/instructor_dto.dart';
import '../services/api_instructor_service.dart';

final apiInstructorServiceProvider = Provider<ApiInstructorService>((ref) {
  return ApiInstructorService();
});

final apiTopAuthorsProvider = FutureProvider<List<InstructorDTO>>((ref) async {
  final service = ref.watch(apiInstructorServiceProvider);
  return service.fetchAllInstructors();
});

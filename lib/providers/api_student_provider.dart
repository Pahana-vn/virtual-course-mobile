import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_dto.dart';
import '../services/api_student_service.dart';

final apiStudentServiceProvider = Provider<ApiStudentService>((ref) {
  return ApiStudentService();
});

final studentCoursesProvider = FutureProvider.family<List<CourseDTO>, int>((ref, studentId) async {
  final service = ref.watch(apiStudentServiceProvider);
  return await service.fetchStudentCourses(studentId);
});

final wishlistProvider = FutureProvider.family<List<CourseDTO>, int>((ref, studentId) async {
  final service = ref.watch(apiStudentServiceProvider);
  return await service.fetchWishlist(studentId);
});

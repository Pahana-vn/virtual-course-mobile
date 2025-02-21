import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_dto.dart';
import '../services/api_course_service.dart';

final apiCourseServiceProvider = Provider<ApiCourseService>((ref) {
  return ApiCourseService();
});

final allCoursesProvider = FutureProvider<List<CourseDTO>>((ref) async {
  final service = ref.watch(apiCourseServiceProvider);
  return service.fetchAllCourses();
});

final courseByIdProvider = FutureProvider.family<CourseDTO, int>((ref, courseId) async {
  final service = ref.watch(apiCourseServiceProvider);
  return service.fetchCourseById(courseId);
});

final coursesByCategoryProvider = FutureProvider.family<List<CourseDTO>, int>((ref, categoryId) async {
  final service = ref.watch(apiCourseServiceProvider);
  return service.fetchCoursesByCategoryId(categoryId);
});
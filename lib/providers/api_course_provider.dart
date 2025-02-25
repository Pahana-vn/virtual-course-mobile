import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_dto.dart';
import '../models/test_dto.dart';
import '../services/api_course_service.dart';

final apiCourseServiceProvider = Provider<ApiCourseService>((ref) {
  return ApiCourseService();
});

final allCoursesProvider = FutureProvider<List<CourseDTO>>((ref) async {
  final service = ref.watch(apiCourseServiceProvider);
  return await service.fetchAllCourses();
});

final courseByIdProvider = FutureProvider.family<CourseDTO, int>((ref, courseId) async {
  final service = ref.watch(apiCourseServiceProvider);
  return await service.fetchCourseById(courseId);
});

final coursesByCategoryProvider = FutureProvider.family<List<CourseDTO>, int>((ref, categoryId) async {
  final service = ref.watch(apiCourseServiceProvider);
  return await service.fetchCoursesByCategoryId(categoryId);
});

final courseDetailsProvider = FutureProvider.autoDispose.family<CourseDTO, Map<String, int>>((ref, params) async {
  final apiService = ref.watch(apiCourseServiceProvider);
  final int courseId = params['courseId']!;
  final int studentId = params['studentId']!;

  return await apiService.fetchCourseDetails(courseId, studentId);
});

final testsByCourseProvider = FutureProvider.family<List<TestDTO>, int>((ref, courseId) async {
  final apiService = ref.watch(apiCourseServiceProvider);
  return await apiService.fetchTestsByCourse(courseId);
});

final searchCoursesProvider = FutureProvider.family<List<CourseDTO>, String>((ref, keyword) async {
  final trimmedKeyword = keyword.trim();
  if (trimmedKeyword.isEmpty) return [];

  final service = ref.watch(apiCourseServiceProvider);
  return await service.searchCourses(trimmedKeyword);
});

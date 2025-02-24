import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_dto.dart';
import '../services/api_course_service.dart';

/// 🟢 Provider cho `ApiCourseService`
final apiCourseServiceProvider = Provider<ApiCourseService>((ref) {
  return ApiCourseService();
});

/// 🟢 FutureProvider để lấy danh sách tất cả khóa học
final allCoursesProvider = FutureProvider<List<CourseDTO>>((ref) async {
  try {
    final service = ref.watch(apiCourseServiceProvider);
    return await service.fetchAllCourses();
  } catch (e) {
    print('❌ Lỗi khi lấy danh sách khóa học: $e');
    throw Exception('Lỗi khi lấy danh sách khóa học');
  }
});

/// 🟢 FutureProvider để lấy thông tin khóa học theo ID
final courseByIdProvider = FutureProvider.family<CourseDTO, int>((ref, courseId) async {
  try {
    final service = ref.watch(apiCourseServiceProvider);
    return await service.fetchCourseById(courseId);
  } catch (e) {
    print('❌ Lỗi khi lấy thông tin khóa học ID: $courseId - $e');
    throw Exception('Lỗi khi lấy thông tin khóa học ID: $courseId');
  }
});

/// 🟢 FutureProvider để lấy danh sách khóa học theo danh mục
final coursesByCategoryProvider = FutureProvider.family<List<CourseDTO>, int>((ref, categoryId) async {
  try {
    final service = ref.watch(apiCourseServiceProvider);
    return await service.fetchCoursesByCategoryId(categoryId);
  } catch (e) {
    print('❌ Lỗi khi lấy danh sách khóa học theo danh mục ID: $categoryId - $e');
    throw Exception('Lỗi khi lấy danh sách khóa học theo danh mục');
  }
});

/// 🟢 FutureProvider để lấy chi tiết khóa học (có Sections & Lectures)
final courseDetailsProvider = FutureProvider.autoDispose.family<CourseDTO, Map<String, int>>((ref, params) async {
  final apiService = ref.watch(apiCourseServiceProvider);
  final int courseId = params['courseId']!;
  final int studentId = params['studentId']!;

  print('📡 Fetching CourseID: $courseId - StudentID: $studentId');

  final course = await apiService.fetchCourseDetails(courseId, studentId);

  print('✅ Course loaded: ${course.titleCourse}, Sections: ${course.sections.length}');

  return course;
});

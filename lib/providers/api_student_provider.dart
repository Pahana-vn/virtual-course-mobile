import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_dto.dart';
import '../services/api_student_service.dart';

/// 🟢 Provider cho `ApiStudentService`
final apiStudentServiceProvider = Provider<ApiStudentService>((ref) {
  return ApiStudentService();
});

/// 🟢 FutureProvider để lấy danh sách khóa học của sinh viên
final studentCoursesProvider = FutureProvider.family<List<CourseDTO>, int>((ref, studentId) async {
  try {
    print('[ApiStudentProvider] - Fetching courses for studentId: $studentId');
    final service = ref.watch(apiStudentServiceProvider);
    final courses = await service.fetchStudentCourses(studentId);
    print('[ApiStudentProvider] - Fetched ${courses.length} courses');
    return courses;
  } catch (e) {
    print('❌ Lỗi khi lấy danh sách khóa học của sinh viên ID: $studentId - $e');
    throw Exception('Lỗi khi lấy danh sách khóa học của sinh viên');
  }
});

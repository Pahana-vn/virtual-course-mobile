import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_dto.dart';
import '../services/api_student_service.dart';

final apiStudentServiceProvider = Provider<ApiStudentService>((ref) {
  return ApiStudentService();
});

final studentCoursesProvider = FutureProvider.family<List<CourseDTO>, int>((ref, studentId) async {
  print('Fetching courses for studentId: $studentId'); // ✅ Debug ID
  final service = ref.watch(apiStudentServiceProvider);
  final courses = await service.fetchStudentCourses(studentId);
  print('Fetched ${courses.length} courses'); // ✅ Debug số lượng course nhận được
  return courses;
});

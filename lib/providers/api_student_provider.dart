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

/// 🟢 FutureProvider để lấy danh sách wishlist của sinh viên
final wishlistProvider = FutureProvider.family<List<CourseDTO>, int>((ref, studentId) async {
  try {
    print('[WishlistProvider] - Fetching wishlist for studentId: $studentId');
    final service = ref.watch(apiStudentServiceProvider);
    final wishlist = await service.fetchWishlist(studentId);
    print('[WishlistProvider] - Fetched ${wishlist.length} wishlist courses');
    return wishlist;
  } catch (e) {
    print('❌ Lỗi khi lấy danh sách wishlist của sinh viên ID: $studentId - $e');
    throw Exception('Lỗi khi lấy danh sách wishlist của sinh viên');
  }
});
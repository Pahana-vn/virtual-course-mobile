import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/course_dto.dart';

class ApiStudentService {
  final String baseUrl = 'http://10.0.2.2:8080/api/students';
  final storage = FlutterSecureStorage();

  Future<List<CourseDTO>> fetchStudentCourses(int studentId) async {
    final token = await storage.read(key: "token"); // ✅ Đọc token từ SecureStorage

    if (token == null) {
      print('❌ Không tìm thấy token, không thể gọi API.');
      throw Exception('Token is missing. Please login again.');
    }

    final url = '$baseUrl/student-courses-status/$studentId?platform=flutter';
    print('📡 Fetching courses from: $url với token: $token'); // ✅ Debug URL + Token

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",  // ✅ Thêm token vào Header
          "Content-Type": "application/json"
        },
      );

      print('✅ Response status: ${response.statusCode}'); // ✅ Debug status code
      print('✅ Response body: ${response.body}'); // ✅ Debug nội dung phản hồi

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> coursesJson = data['enrolled'] ?? [];

        print('✅ Courses received: ${coursesJson.length}'); // ✅ Debug số lượng course

        return coursesJson.map((e) => CourseDTO.fromJson(e)).toList();
      } else if (response.statusCode == 403) {
        print('❌ API từ chối truy cập (403). Kiểm tra quyền của user.');
        throw Exception('Unauthorized access - You do not have permission.');
      } else if (response.statusCode == 401) {
        print('❌ Token không hợp lệ hoặc hết hạn (401). Cần đăng nhập lại.');
        throw Exception('Invalid or expired token. Please login again.');
      } else {
        print('❌ API trả về lỗi không xác định: ${response.body}');
        throw Exception('Failed to load student courses. Error: ${response.body}');
      }
    } catch (e) {
      print('❌ Lỗi khi gọi API: $e');
      throw Exception('Failed to load student courses');
    }
  }
}

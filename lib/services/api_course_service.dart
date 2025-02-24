import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/course_dto.dart';
import '../models/test_dto.dart';

class ApiCourseService {
  final String baseUrl = 'http://10.0.2.2:8080/api/courses';
  final storage = FlutterSecureStorage();

  /// 🟢 Lấy danh sách tất cả khóa học
  Future<List<CourseDTO>> fetchAllCourses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?platform=flutter'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((e) => CourseDTO.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      throw Exception('❌ Lỗi khi gọi API fetchAllCourses: $e');
    }
  }

  /// 🟢 Lấy thông tin khóa học theo ID
  Future<CourseDTO> fetchCourseById(int courseId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$courseId?platform=flutter'));

      if (response.statusCode == 200) {
        return CourseDTO.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load course with ID: $courseId');
      }
    } catch (e) {
      throw Exception('❌ Lỗi khi gọi API fetchCourseById: $e');
    }
  }

  /// 🟢 Lấy danh sách khóa học theo danh mục
  Future<List<CourseDTO>> fetchCoursesByCategoryId(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/by-category?categoryId=$categoryId&platform=flutter'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((e) => CourseDTO.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load courses by category ID: $categoryId');
      }
    } catch (e) {
      throw Exception('❌ Lỗi khi gọi API fetchCoursesByCategoryId: $e');
    }
  }

  /// 🟢 Lấy chi tiết khóa học (gồm Sections & Lectures) cho sinh viên
  Future<CourseDTO> fetchCourseDetails(int courseId, int studentId) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        throw Exception('Token is missing. Please login again.');
      }

      // ✅ Đảm bảo URL đúng chuẩn, thêm query parameters an toàn
      final Uri url = Uri.parse('$baseUrl/$courseId/details-for-student')
          .replace(queryParameters: {"studentId": studentId.toString(), "platform": "flutter"});

      print('📡 API Request URL: $url'); // ✅ Debug URL để kiểm tra

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      print('📡 API Response Status: ${response.statusCode}'); // ✅ Debug status
      print('📡 API Response Body: ${response.body}'); // ✅ Debug nội dung trả về

      if (response.statusCode == 200) {
        final Map<String, dynamic> courseJson = jsonDecode(response.body);
        print('✅ Successfully parsed Course: ${courseJson['titleCourse']}');
        return CourseDTO.fromJson(courseJson);
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized access - You do not have permission.');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or expired token. Please login again.');
      } else {
        throw Exception('Failed to load course details for course ID: $courseId. Error: ${response.body}');
      }
    } catch (e) {
      print('❌ Lỗi khi gọi API fetchCourseDetails: $e');
      throw Exception('❌ Lỗi khi gọi API fetchCourseDetails: $e');
    }
  }

  /// Lấy danh sách bài kiểm tra của khóa học
  Future<List<TestDTO>> fetchTestsByCourse(int courseId) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        throw Exception('Token is missing. Please login again.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/$courseId/tests'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((e) => TestDTO.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load tests for course ID: $courseId');
      }
    } catch (e) {
      throw Exception('❌ Lỗi khi gọi API fetchTestsByCourse: $e');
    }
  }
}

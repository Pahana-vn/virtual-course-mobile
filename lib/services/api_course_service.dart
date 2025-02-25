import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/course_dto.dart';
import '../models/test_dto.dart';

class ApiCourseService {
  final String baseUrl = 'http://10.0.2.2:8080/api/courses';
  final storage = FlutterSecureStorage();

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
      throw Exception('Error when calling fetchAllCourses API: $e');
    }
  }

  Future<CourseDTO> fetchCourseById(int courseId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$courseId?platform=flutter'));

      if (response.statusCode == 200) {
        return CourseDTO.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load course with ID: $courseId');
      }
    } catch (e) {
      throw Exception('Lỗi khi gọi API fetchCourseById: $e');
    }
  }

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
      throw Exception('Error when calling API fetchCoursesByCategoryId: $e');
    }
  }

  Future<CourseDTO> fetchCourseDetails(int courseId, int studentId) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        throw Exception('Token is missing. Please login again.');
      }

      final Uri url = Uri.parse('$baseUrl/$courseId/details-for-student')
          .replace(queryParameters: {"studentId": studentId.toString(), "platform": "flutter"});

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> courseJson = jsonDecode(response.body);
        return CourseDTO.fromJson(courseJson);
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized access - You do not have permission.');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or expired token. Please login again.');
      } else {
        throw Exception('Failed to load course details for course ID: $courseId. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error calling fetchCourseDetails API: $e');
    }
  }

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
      throw Exception('Error when calling fetchTestsByCourse API: $e');
    }
  }

  Future<List<CourseDTO>> searchCourses(String keyword) async {
    try {
      if (keyword.isEmpty) {
        return [];
      }

      final Uri url = Uri.parse('$baseUrl/search-flutter')
          .replace(queryParameters: {"keyword": keyword, "platform": "flutter"});

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((e) => CourseDTO.fromJson(e)).toList();
      } else {
        throw Exception('No courses found matching your keyword: $keyword');
      }
    } catch (e) {
      throw Exception('Error while searching for course: $e');
    }
  }
}

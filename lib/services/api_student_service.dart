import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/course_dto.dart';

class ApiStudentService {
  final String baseUrl = 'http://10.0.2.2:8080/api/students';
  final storage = FlutterSecureStorage();

  Future<List<CourseDTO>> fetchStudentCourses(int studentId) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        throw Exception('Token is missing. Please login again.');
      }

      final url = '$baseUrl/student-courses-status/$studentId?platform=flutter';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> coursesJson = data['enrolled'] ?? [];
        return coursesJson.map((e) => CourseDTO.fromJson(e)).toList();
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized access - You do not have permission.');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or expired token. Please login again.');
      } else {
        throw Exception('Failed to load student courses. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('❌ Lỗi khi gọi API fetchStudentCourses: $e');
    }
  }
}

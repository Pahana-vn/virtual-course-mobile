// services/api_course_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course_dto.dart';

class ApiCourseService {
  final String baseUrl = 'http://10.0.2.2:8080/api/courses?platform=flutter';

  /// Lấy tất cả khoá học
  Future<List<CourseDTO>> fetchAllCourses() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => CourseDTO.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  /// Lấy khoá học theo ID
  Future<CourseDTO> fetchCourseById(int id) async {
    final url = '$baseUrl/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return CourseDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load course with id $id');
    }
  }

  Future<List<CourseDTO>> fetchCoursesByCategoryId(int categoryId) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/api/courses/by-category?categoryId=$categoryId&platform=flutter'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => CourseDTO.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load courses by category');
    }
  }

}

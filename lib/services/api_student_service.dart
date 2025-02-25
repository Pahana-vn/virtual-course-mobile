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
      throw Exception('Error while calling API fetchStudentCourses: $e');
    }
  }

  Future<List<CourseDTO>> fetchWishlist(int studentId) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) throw Exception('Token is missing. Please login again.');

      final Uri url = Uri.parse('$baseUrl/$studentId/wishlist').replace(queryParameters: {"platform": "flutter"});

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> coursesJson = jsonDecode(response.body);
        return coursesJson.map((e) => CourseDTO.fromJson(e)).toList();
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized access - You do not have permission.');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or expired token. Please login again.');
      } else {
        throw Exception('Failed to load wishlist. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error while calling API fetchWishlist: $e');
    }
  }

  Future<bool> addToWishlist(int studentId, CourseDTO course) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) throw Exception('Token is missing. Please login again.');

      final response = await http.post(
        Uri.parse('$baseUrl/$studentId/wishlist'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode(course.toJson()),
      );

      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error while adding to wishlist: $e');
    }
  }

  Future<bool> removeFromWishlist(int studentId, int courseId) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) throw Exception('Token is missing. Please login again.');

      final response = await http.delete(
        Uri.parse('$baseUrl/$studentId/wishlist/$courseId'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Error while removing from wishlist: $e');
    }
  }
}

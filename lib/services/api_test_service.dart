import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/test_submission_dto.dart';

class ApiTestService {
  final String baseUrl = 'http://10.0.2.2:8080/api/tests';
  final storage = FlutterSecureStorage();

  /// Nộp bài kiểm tra
  Future<Map<String, dynamic>> submitTest(TestSubmissionDTO submission) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        throw Exception('Token is missing. Please login again.');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/submit'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode(submission.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit test. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error in submitTest: $e');
    }
  }
}

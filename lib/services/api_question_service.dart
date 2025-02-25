import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/question_dto.dart';

class ApiQuizService {
  final String baseUrl = 'http://10.0.2.2:8080/api/questions';
  final storage = FlutterSecureStorage();

  Future<List<QuestionDTO>> fetchQuestionsByTest(int testId) async {
    try {
      final token = await storage.read(key: "token");
      if (token == null) {
        throw Exception('Token is missing. Please login again.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/test/$testId'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((e) => QuestionDTO.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load questions for test ID: $testId');
      }
    } catch (e) {
      throw Exception('Error when calling fetchQuestionsByTest API: $e');
    }
  }
}
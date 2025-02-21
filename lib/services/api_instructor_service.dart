// services/api_instructor_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/instructor_dto.dart';

class ApiInstructorService {
  final String baseUrl = 'http://10.0.2.2:8080/api/instructors';

  Future<List<InstructorDTO>> fetchAllInstructors() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => InstructorDTO.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load instructors');
    }
  }

// ... fetchInstructorById, create, update, delete ...
}

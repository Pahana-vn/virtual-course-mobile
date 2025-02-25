// services/api_category_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_dto.dart';

class ApiCategoryService {
  final String baseUrl = 'http://10.0.2.2:8080/api/categories?platform=flutter';

  Future<List<CategoryDTO>> fetchAllCategories() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => CategoryDTO.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

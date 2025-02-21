import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // ✅ Thêm import
import '../models/api_user_model.dart';

// API endpoint
const String apiUrl = "http://10.0.2.2:8080/api/students/";

final apiUserProvider = StateNotifierProvider<ApiUserNotifier, ApiUserModel?>((ref) {
  return ApiUserNotifier();
});

class ApiUserNotifier extends StateNotifier<ApiUserModel?> {
  ApiUserNotifier() : super(null);

  final FlutterSecureStorage _storage = FlutterSecureStorage(); // ✅ Khai báo storage

  // Fetch user từ API theo studentId
  Future<void> fetchUser(int studentId) async {
    try {
      final token = await _storage.read(key: "token"); // ✅ Đổi storage thành _storage

      print("📡 Fetching user from API: $apiUrl$studentId with token: $token");

      final response = await http.get(
        Uri.parse('$apiUrl$studentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // ✅ Gửi JWT token
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        state = ApiUserModel.fromJson(data);
        print("🎉 User data fetched: ${state?.username}, ${state?.email}");
      } else {
        print("❌ Failed to fetch user: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("❌ Error fetching user: $e");
    }
  }

  // Logout user
  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('studentId'); // Xóa studentId khi logout
    await _storage.delete(key: "token"); // ✅ Xóa token khi logout
    state = null;
  }
}

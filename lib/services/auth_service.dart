import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/api_user_model.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:8080/api/auth";

  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // ✅ Lưu token & thông tin user
      await storage.write(key: "token", value: data["token"]);
      await storage.write(key: "accountId", value: data["accountId"].toString());
      await storage.write(key: "studentId", value: data["studentId"].toString());

      List roles = data["roles"] ?? [];
      await storage.write(key: "role", value: jsonEncode(roles));

      return data;
    } else {
      return null;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
        "role": "STUDENT"
      }),
    );

    return response.statusCode == 200;
  }

  Future<ApiUserModel?> fetchUser(int studentId) async {
    final String url = "http://10.0.2.2:8080/api/students/$studentId";
    final token = await getToken();

    if (token == null) {
      print("[AuthService] -No token, can't fetch user");
      return null;
    }

    print("[AuthService] - Fetching user from API: $url với token: $token");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("📡 [AuthService] - Response status: ${response.statusCode}");
    print("📡 [AuthService] - Response body: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ApiUserModel.fromJson(data);
    } else {
      print("❌ [AuthService] - Error fetch user: ${response.body}");
      return null;
    }
  }

  Future<bool> enrollCourse(String userId, String courseId) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/courses/enroll'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId, "courseId": courseId}),
    );

    return response.statusCode == 200;
  }

  Future<void> logout() async {
    await storage.delete(key: "token");
  }

  Future<String?> getToken() async {
    String? token = await storage.read(key: "token");

    if (token == null) {
      print("Token not found, please login again.");
      return null;
    }

    if (JwtDecoder.isExpired(token)) {
      print("Token has expired, please log in again.");
      await logout();
      return null;
    }

    return token;
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  Future<bool> deleteUserAuth(String userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$userId'),
      headers: {"Content-Type": "application/json"},
    );

    return response.statusCode == 200;
  }

  Future<void> userLogOut() async {
    await storage.delete(key: "token");
  }

  Future<void> googleLogout() async {
    print("Google logout called");
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:8080/api/auth"; // 🔹 Thay URL backend nếu cần

  final storage = FlutterSecureStorage();

  /// 📌 **Đăng nhập với email & password**
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

      // ✅ Lưu ROLE vào storage
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


  /// 📌 **Đăng ký khóa học**
  Future<bool> enrollCourse(String userId, String courseId) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/courses/enroll'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId, "courseId": courseId}),
    );


    return response.statusCode == 200;
  }

  /// 📌 **Đăng xuất (Xóa token)**
  Future<void> logout() async {
    await storage.delete(key: "token");
  }

  /// 📌 **Lấy token từ storage**
  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  /// 📌 **Kiểm tra xem user đã đăng nhập chưa**
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  /// 📌 **Xóa tài khoản người dùng**
  Future<bool> deleteUserAuth(String userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$userId'),
      headers: {"Content-Type": "application/json"},
    );

    return response.statusCode == 200;
  }

  /// 📌 **Đăng xuất**
  Future<void> userLogOut() async {
    await storage.delete(key: "token");
  }

  /// 📌 **Đăng xuất Google (Nếu có)**
  Future<void> googleLogout() async {
    // Nếu không dùng Google Auth, có thể bỏ qua
    print("Google logout called");
  }
}

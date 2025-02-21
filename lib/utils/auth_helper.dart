import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthHelper {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Kiểm tra quyền ROLE_STUDENT từ token
  static Future<bool> checkUserRole() async {
    final String? roleData = await _storage.read(key: "role");

    if (roleData != null) {
      print("🔍 RoleData từ SecureStorage: $roleData");

      try {
        // Kiểm tra xem roleData có phải danh sách JSON không
        List<dynamic> parsedRoles;
        if (roleData.startsWith('[') && roleData.endsWith(']')) {
          parsedRoles = jsonDecode(roleData); // Giải mã JSON từ String
        } else {
          parsedRoles = [roleData]; // Nếu roleData chỉ là một chuỗi, chuyển thành danh sách
        }

        // Duyệt danh sách roles để lấy giá trị authority (nếu có)
        List<String> roleList = parsedRoles.map((role) {
          if (role is Map<String, dynamic>) {
            return role["authority"].toString();
          } else if (role is String) {
            return role; // Trường hợp chỉ là một chuỗi như "ROLE_STUDENT"
          }
          return "";
        }).toList();

        print("🔍 Danh sách roles sau decode: $roleList");

        if (roleList.contains("ROLE_STUDENT")) {
          print("✅ User có quyền ROLE_STUDENT");
          return true;
        }
      } catch (e) {
        print("❌ Lỗi khi parse roleData: $e");
      }
    }

    print("🚫 User không có quyền ROLE_STUDENT");
    return false;
  }
}

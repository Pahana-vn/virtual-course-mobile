import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/api_user_model.dart';
import '../screens/auth/login.dart';
import '../services/auth_service.dart';

final apiUserDataProvider = StateProvider<ApiUserModel?>((ref) => null);

/// 📌 **Lấy dữ liệu user từ API & kiểm tra token**
Future<void> fetchApiUserData(WidgetRef ref, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final studentId = prefs.getInt('studentId');

  print('📌 [api_user_data_provider] - Đọc studentId từ SharedPreferences: $studentId');

  if (studentId == null) {
    print('❌ Không tìm thấy studentId, yêu cầu đăng nhập lại.');
    _redirectToLogin(context);
    return;
  }

  final authService = AuthService();
  final token = await authService.getToken();

  if (token == null) {
    print("❌ Token hết hạn, yêu cầu đăng nhập lại.");
    await authService.logout();
    ref.read(apiUserDataProvider.notifier).state = null;
    _redirectToLogin(context);
    return;
  }

  try {
    final user = await authService.fetchUser(studentId);
    if (user != null) {
      print('✅ User fetched: ${user.username}');
      ref.read(apiUserDataProvider.notifier).state = user;
    } else {
      print('❌ API trả về null!');
      _redirectToLogin(context);
    }
  } catch (e) {
    print('❌ Lỗi khi fetch user: $e');
    _redirectToLogin(context);
  }
}

/// ✅ **Hàm điều hướng về trang đăng nhập**
void _redirectToLogin(BuildContext context) {
  Future.delayed(Duration.zero, () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // ✅ Điều hướng đúng
          (route) => false, // Xóa tất cả các màn hình trước đó
    );
  });
}

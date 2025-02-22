import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/api_user_model.dart';
import '../services/auth_service.dart';

final apiUserDataProvider = StateProvider<ApiUserModel?>((ref) => null); // ✅ Provider lưu dữ liệu user

/// 📌 **Hàm fetch dữ liệu user từ API & cập nhật vào Provider**
Future<void> fetchApiUserData(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final studentId = prefs.getInt('studentId');

  print('📌 [api_user_data_provider] - Đọc studentId từ SharedPreferences: $studentId');

  if (studentId == null) {
    print('❌ [api_user_data_provider] - Không tìm thấy studentId, không thể lấy user!');
    return;
  }

  try {
    final authService = AuthService();
    final user = await authService.fetchUser(studentId);
    if (user != null) {
      print('✅ [api_user_data_provider] - User fetched: ${user.username}');
      ref.read(apiUserDataProvider.notifier).state = user; // ✅ Cập nhật Provider
    } else {
      print('❌ [api_user_data_provider] - API trả về null!');
    }
  } catch (e) {
    print('❌ [api_user_data_provider] - Lỗi khi fetch user: $e');
  }
}

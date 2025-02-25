import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/api_user_model.dart';
import '../screens/auth/login.dart';
import '../services/auth_service.dart';

final apiUserDataProvider = StateProvider<ApiUserModel?>((ref) => null);

Future<void> fetchApiUserData(WidgetRef ref, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final studentId = prefs.getInt('studentId');

  if (studentId == null) {
    _redirectToLogin(context);
    return;
  }

  final authService = AuthService();
  final token = await authService.getToken();

  if (token == null) {
    await authService.logout();
    ref.read(apiUserDataProvider.notifier).state = null;
    _redirectToLogin(context);
    return;
  }

  try {
    final user = await authService.fetchUser(studentId);
    if (user != null) {
      ref.read(apiUserDataProvider.notifier).state = user;
    } else {
      _redirectToLogin(context);
    }
  } catch (e) {
    _redirectToLogin(context);
  }
}

void _redirectToLogin(BuildContext context) {
  Future.delayed(Duration.zero, () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  });
}

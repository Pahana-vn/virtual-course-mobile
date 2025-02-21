import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lms_app/screens/intro.dart';
import 'package:lms_app/utils/api_next_screen.dart';
import 'package:lms_app/utils/auth_helper.dart';
import '../core/home.dart';
import '../providers/api_user_provider.dart';

class ApiSplashScreen extends ConsumerStatefulWidget {
  const ApiSplashScreen({super.key});

  @override
  ConsumerState<ApiSplashScreen> createState() => _ApiSplashScreenState();
}

class _ApiSplashScreenState extends ConsumerState<ApiSplashScreen> {
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final int? studentId = prefs.getInt('studentId');

    if (studentId != null && await AuthHelper.checkUserRole()) {
      print("✅ User có ROLE_STUDENT, tiếp tục vào hệ thống...");
      await ref.read(apiUserProvider.notifier).fetchUser(studentId);

      if (!mounted) return;
      ApiNextScreen.replaceAnimation(context, const Home());
    } else {
      print("🚪 Không tìm thấy studentId hoặc không có quyền, chuyển về login");
      if (!mounted) return;
      ApiNextScreen.replaceAnimation(context, const IntroScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

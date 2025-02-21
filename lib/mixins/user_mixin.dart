import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/iAP/iap_config.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/providers/app_settings_provider.dart';
import 'package:lms_app/screens/curricullam_screen.dart';
import 'package:lms_app/screens/home/home_bottom_bar.dart';
import 'package:lms_app/screens/home/home_view.dart';
import 'package:lms_app/screens/intro.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:lms_app/services/auth_service.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';
import '../iAP/iap_screen.dart';
import '../models/app_settings_model.dart';
import '../providers/user_data_provider.dart';

mixin UserMixin {

  /// 📌 **Đăng xuất tài khoản**
  void handleLogout(BuildContext context, {required WidgetRef ref}) async {
    await AuthService().logout().onError((error, stackTrace) => debugPrint('Lỗi đăng xuất: $error'));

    ref.invalidate(userDataProvider);
    ref.invalidate(homeTabControllerProvider);
    ref.invalidate(navBarIndexProvider);

    NextScreen.closeOthersAnimation(context, IntroScreen());
  }

  /// 📌 **Kiểm tra user đã đăng ký khóa học chưa**
  bool hasEnrolled(dynamic user, Course course) {
    return user != null && user["enrolledCourses"] != null && user["enrolledCourses"].contains(course.id);
  }

  /// 📌 **Xử lý đăng ký khóa học**
  Future<void> handleEnrollment(
      BuildContext context, {
        required dynamic user,
        required Course course,
        required WidgetRef ref,
      }) async {
    if (user != null) {
      if (course.priceStatus == 'free') {
        // ✅ Khóa học miễn phí
        if (hasEnrolled(user, course)) {
          NextScreen.popup(context, CurriculamScreen(course: course));
        } else {
          AdManager.initInterstitailAds(ref);
          await _confirmEnrollment(context, user, course, ref);
        }
      } else {
        // 🔹 Khóa học trả phí
        if (user["subscription"] != null && !isExpired(user)) {
          if (hasEnrolled(user, course)) {
            NextScreen.popup(context, CurriculamScreen(course: course));
          } else {
            await _confirmEnrollment(context, user, course, ref);
          }
        } else {
          // Kiểm tra giấy phép (license)
          final settings = ref.read(appSettingsProvider);
          if (IAPConfig.iAPEnabled && settings?.license == LicenseType.extended) {
            NextScreen.openBottomSheet(context, IAPScreen(), isDismissable: false);
          } else {
            openSnackbarFailure(context, 'Cần giấy phép mở rộng!');
          }
        }
      }
    } else {
      NextScreen.openBottomSheet(context, LoginScreen());
    }
  }

  /// 📌 **Xác nhận đăng ký khóa học**
  Future<void> _confirmEnrollment(BuildContext context, dynamic user, Course course, WidgetRef ref) async {
    // ✅ Gửi yêu cầu đăng ký khóa học lên backend Java Spring Boot
    final response = await AuthService().enrollCourse(user["id"], course.id);

    if (response) {
      await ref.read(userDataProvider.notifier).getData();
      if (!context.mounted) return;
      openSnackbar(context, 'Đã đăng ký thành công!');
    } else {
      openSnackbarFailure(context, 'Đăng ký thất bại, vui lòng thử lại.');
    }
  }

  /// 📌 **Mở khóa học**
  Future<void> handleOpenCourse(
      BuildContext context, {
        required dynamic user,
        required Course course,
      }) async {
    if (course.priceStatus == 'free' || (user["subscription"] != null && !isExpired(user))) {
      NextScreen.popup(context, CurriculamScreen(course: course));
    } else {
      NextScreen.openBottomSheet(context, IAPScreen());
    }
  }

  /// 📌 **Kiểm tra user có gói premium không**
  static bool isUserPremium(dynamic user) {
    return user != null && user["subscription"] != null && !isExpired(user);
  }

  /// 📌 **Kiểm tra subscription hết hạn chưa**
  static bool isExpired(dynamic user) {
    if (user["subscription"] == null) return true;

    final DateTime expireDate = DateTime.parse(user["subscription"]["expireAt"]);
    final DateTime now = DateTime.now().toUtc();
    return expireDate.isBefore(now);
  }
}

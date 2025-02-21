import 'package:flutter/material.dart';

class ApiNextScreen {
  /// Mở BottomSheet và nhận kết quả (vd: studentId sau khi login)
  static Future<int?> openBottomSheet(BuildContext context, Widget page, {double maxHeight = 0.95, bool isDismissable = true}) async {
    final result = await showModalBottomSheet<int>(
      enableDrag: isDismissable,
      isScrollControlled: true,
      isDismissible: isDismissable,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.50,
        maxHeight: MediaQuery.of(context).size.height * maxHeight,
      ),
      context: context,
      builder: (context) => page,
    );
    return result; // Trả về studentId hoặc null nếu đóng BottomSheet
  }

  /// **Chuyển sang màn hình khác và thay thế màn hình hiện tại (pushReplacement)**
  static void replaceAnimation(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) =>
      page,
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          FadeTransition(
            opacity: animation,
            child: child,
          ),
    ));
  }

  /// **Chuyển sang màn hình khác và xóa hết các màn hình trước đó**
  static void closeOthersAnimation(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            ) =>
        page,
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
            ) =>
            FadeTransition(
              opacity: animation,
              child: child,
            ),
      ),
          (route) => false, // Xóa hết các màn hình trước đó
    );
  }

  /// **Chuyển đến màn hình khác mà không thay thế màn hình hiện tại**
  static void normal(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }


  /// **Thay thế màn hình hiện tại mà không có animation**
  static void replace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// **Đóng tất cả các màn hình trước đó và chuyển đến màn hình mới**
  static void closeOthers(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
          (route) => false, // Xóa hết các màn hình trước đó
    );
  }
}

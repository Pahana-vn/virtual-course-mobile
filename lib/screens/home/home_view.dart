import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/home/home_bottom_bar.dart';
import 'package:lms_app/screens/tabs/home_tab/home_tab.dart';
import 'package:lms_app/screens/tabs/profile_tab/profile_tab.dart';
import 'package:lms_app/screens/tabs/search_tab/search_tab.dart';
import '../tabs/my_courses_tab/api_my_courses_tab.dart';
import '../../../providers/api_user_data_provider.dart'; // ✅ Import file xử lý dữ liệu user

final homeTabControllerProvider = StateProvider<PageController>((ref) => PageController(initialPage: 0));

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchApiUserData(ref, context); // ✅ Sửa lỗi: Truyền thêm context
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabController = ref.watch(homeTabControllerProvider);
    final user = ref.watch(apiUserDataProvider);

    print('----------------------');
    print('[HomeView] - User data: $user');

    if (user == null) {
      print('[HomeView] - User is null. Showing loading indicator.');
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final studentId = int.tryParse(user.id.toString());
    print('[HomeView] - Student ID (Parsed): $studentId');

    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: PageView(
        allowImplicitScrolling: true,
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomeTab(),
          const SearchTab(),
          studentId != null
              ? ApiMyCoursesTab(studentId: studentId!)
              : const Center(child: CircularProgressIndicator()),
          const ProfileTab(),
        ],
      ),
    );
  }
}

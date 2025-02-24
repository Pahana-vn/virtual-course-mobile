import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lms_app/components/loading_list_tile.dart';
import 'package:lms_app/utils/empty_animation.dart';
import '../components/api_course_title.dart';
import '../components/course_tile.dart';
import '../configs/app_assets.dart';
import '../models/course_dto.dart';
import '../providers/api_student_provider.dart';

class Wishlist extends ConsumerWidget {
  const Wishlist({super.key});

  Future<int?> _getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('studentId');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<int?>(
      future: _getStudentId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text("Error: Student ID not found"));
        }

        final studentId = snapshot.data!;
        final wishlist = ref.watch(wishlistProvider(studentId));

        return Scaffold(
          appBar: AppBar(
            title: const Text('wishlist').tr(),
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(FeatherIcons.chevronLeft),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async => ref.refresh(wishlistProvider(studentId)),
            child: wishlist.when(
              skipLoadingOnRefresh: false,
              loading: () => const LoadingListTile(height: 160),
              error: (error, stackTrace) => Center(child: Text(error.toString())),
              data: (data) {
                if (data.isEmpty) {
                  return EmptyAnimation(animationString: emptyAnimation, title: 'no-course'.tr());
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const Divider(height: 50),
                  itemBuilder: (context, index) {
                    final CourseDTO course = data[index];
                    return ApiCourseTile(course: course); // ✅ Dùng CourseDTO thay vì Course
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

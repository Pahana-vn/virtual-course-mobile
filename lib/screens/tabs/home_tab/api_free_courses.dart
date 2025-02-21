import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/models/course_dto.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../providers/api_course_provider.dart';
import '../../all_courses.dart/courses_view.dart';
import '../../../components/api_horizontal_course_tile.dart'; // ✅ Import file mới

class ApiFreeCourses extends ConsumerWidget {
  const ApiFreeCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(allCoursesProvider);

    return courses.when(
      skipLoadingOnRefresh: false,
      data: (List<CourseDTO> allCourses) {
        if (allCourses.isEmpty) return const SizedBox();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'explore'.tr(),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: 'free-courses'.tr(),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => NextScreen.iOS(
                        context,
                        const AllCoursesView(courseBy: CourseBy.free, title: 'Free Courses'),
                      ),
                      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                      child: Text(
                        'view-all',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ).tr(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: allCourses.map((course) {
                    return ApiHorizontalCourseTile(
                      courseDTO: course, // ✅ Dùng CourseDTO
                      widthPercentage: 0.60,
                      imageHeight: 130,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
      error: (e, x) => Center(child: Text('Error loading free courses: $e')),
      loading: () => const LoadingTile(height: 200),
    );
  }
}

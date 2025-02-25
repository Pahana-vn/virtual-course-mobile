import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/models/course_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/api_course_provider.dart';
import '../../course_details.dart/api_course_details_buy.dart';
import '../../../components/api_horizontal_course_tile.dart';

class ApiCategory3Courses extends ConsumerWidget {
  const ApiCategory3Courses({super.key});

  Future<int?> _getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('studentId');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int categoryId = 3;
    final courses = ref.watch(coursesByCategoryProvider(categoryId));

    print("Fetching courses for categoryId: $categoryId");

    return FutureBuilder<int?>(
      future: _getStudentId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("Error: Student ID not found"));
        }

        final studentId = snapshot.data!;

        return courses.when(
          data: (List<CourseDTO> categoryCourses) {
            if (categoryCourses.isEmpty) return const SizedBox();
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
                              text: 'top-courses-in'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: " Business",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categoryCourses.map((course) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ApiCourseDetailsBuy(
                                  courseId: course.id,
                                  studentId: studentId,
                                ),
                              ),
                            );
                          },
                          child: ApiHorizontalCourseTile(
                            courseDTO: course,
                            widthPercentage: 0.40,
                            imageHeight: 100,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (e, x) => Center(child: Text('Error loading category courses: $e')),
          loading: () => const LoadingTile(height: 200),
        );
      },
    );
  }
}
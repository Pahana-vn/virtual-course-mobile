import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_list_tile.dart';
import 'package:lms_app/configs/app_assets.dart';
import 'package:lms_app/utils/empty_animation.dart';
import 'package:lms_app/providers/api_student_provider.dart';
import 'api_my_course_title.dart';

class ApiMyCoursesTab extends ConsumerWidget {
  final int studentId;

  const ApiMyCoursesTab({super.key, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('----------------------');
    print('[ApiMyCoursesTab] - Rendering for studentId: $studentId');

    final courses = ref.watch(studentCoursesProvider(studentId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('my-courses').tr(),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          print('[ApiMyCoursesTab] - Refreshing courses for studentId: $studentId');
          await ref.refresh(studentCoursesProvider(studentId));
        },
        child: courses.when(
          loading: () {
            print('[ApiMyCoursesTab] - Loading courses...');
            return const LoadingListTile(height: 200);
          },
          error: (error, stackTrace) {
            print('[ApiMyCoursesTab] - Error loading courses: $error');
            print('Stacktrace: $stackTrace');
            return Center(child: Text('Error: $error\n$stackTrace'));
          },
          data: (data) {
            print('[ApiMyCoursesTab] - Courses loaded: ${data.length}');

            if (data.isEmpty) {
              print('[ApiMyCoursesTab] - No courses found for studentId: $studentId');
              return const EmptyAnimation(
                animationString: emptyAnimation,
                title: 'No courses found',
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 25),
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(height: 50),
              itemBuilder: (context, index) {
                print('[ApiMyCoursesTab] - Rendering course: ${data[index].titleCourse}');
                return ApiMyCourseTile(course: data[index], studentId: studentId);
              },
            );
          },
        ),
      ),
    );
  }
}

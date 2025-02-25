import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/api_course_title.dart';
import '../../components/loading_list_tile.dart';
import '../../configs/app_assets.dart';
import '../../models/course_dto.dart';
import '../../providers/api_course_provider.dart';
import '../../utils/empty_animation.dart';
import 'api_search_view.dart';

class ApiSearchedCourses extends ConsumerWidget {
  const ApiSearchedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchTextCtlrProvider).text.trim();

    if (searchText.isEmpty) {
      print("No valid keywords found, please enter...");
      return Center(
        child: Text(
          "Please enter keywords to search",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }

    final searchedCourses = ref.watch(searchCoursesProvider(searchText));

    return searchedCourses.when(
      loading: () {
        print("Loading search results...");
        return const LoadingListTile(height: 160);
      },
      error: (error, stackTrace) {
        print("Error while searching: $error");
        return Center(child: Text("Error: $error"));
      },
      data: (courses) {
        print("Find ${courses.length} course with keyword '$searchText'");

        if (courses.isEmpty) {
          return EmptyAnimation(animationString: emptyAnimation, title: "No course found".tr());
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: courses.length,
          separatorBuilder: (context, index) => const Divider(height: 50),
          itemBuilder: (context, index) {
            final CourseDTO course = courses[index];
            print("📌 [LOG] Course Found: ${course.titleCourse}");
            return ApiCourseTile(course: course);
          },
        );
      },
    );
  }
}

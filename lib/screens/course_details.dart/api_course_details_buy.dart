import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/course_dto.dart';
import '../../providers/api_course_provider.dart';
import 'api_bookmark_button.dart';
import 'api_course_description.dart';
import 'api_preview_box.dart';
import 'api_requirements.dart';
import 'api_title_info.dart';
import 'api_course_info.dart';
import 'api_learnings.dart';
import 'bookmark_button.dart';

class ApiCourseDetailsBuy extends ConsumerWidget {
  final int courseId;
  final int studentId;

  const ApiCourseDetailsBuy({super.key, required this.courseId, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseDetails = ref.read(courseDetailsProvider({"courseId": courseId, "studentId": studentId}));

    return Scaffold(
      body: FutureBuilder<CourseDTO>(
        future: ref.read(apiCourseServiceProvider).fetchCourseDetails(courseId, studentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  Text("Failed to load course details.\nError: ${snapshot.error}", textAlign: TextAlign.center),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data found."));
          }

          final course = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(FeatherIcons.chevronLeft),
                ),
                actions: [
                  ApiBookmarkButton(course: course),
                  const SizedBox(width: 10),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ApiPreviewBox(course: course),
                      const SizedBox(height: 20),
                      ApiTitleInfo(course: course),
                      ApiCourseInfo(course: course),
                      ApiLearnings(),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.redAccent),
                          ),
                          child: const Row(
                            children: [
                              Icon(FeatherIcons.alertCircle, color: Colors.redAccent),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "You need to register for the course to view the lecture.",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ApiRequirements(),
                      ApiCourseDescription(course: course),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Xử lý logic mua khóa học tại đây
            print("Buy Now Pressed");
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text(
            "Buy Now",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

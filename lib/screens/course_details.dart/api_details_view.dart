import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/course_dto.dart';
import '../../providers/api_course_provider.dart';
import '../quiz_lesson/api_quiz_screen.dart';
import 'api_course_description.dart';
import 'api_curriculam.dart';
import 'api_preview_box.dart';
import 'api_requirements.dart';
import 'api_title_info.dart';
import 'api_course_info.dart';
import 'api_learnings.dart';

class ApiCourseDetailsView extends ConsumerWidget {
  final int courseId;
  final int studentId;

  const ApiCourseDetailsView({super.key, required this.courseId, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lấy thông tin khóa học
    final courseDetails = ref.read(courseDetailsProvider({"courseId": courseId, "studentId": studentId}));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Details"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(FeatherIcons.chevronLeft),
        ),
      ),
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
                      const SizedBox(height: 40),

                      // Kiểm tra nếu có sections trong khóa học
                      if (course.sections.isNotEmpty)
                        ApiCurriculam(course: course)
                      else
                        const Center(
                          child: Text(
                            "No sections available in this course.",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),

                      const SizedBox(height: 10),

                      // Nếu khóa học có bài kiểm tra cuối cùng
                      if (course.finalTestId != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (course.allLecturesCompleted)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ApiQuizScreen(
                                            courseId: course.id,
                                            studentId: studentId,
                                              testId: course.finalTestId!,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      backgroundColor: Colors.blueAccent,
                                    ),
                                    child: const Text(
                                      "Take My Test",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            else
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
                                  child: Row(
                                    children: [
                                      const Icon(FeatherIcons.alertCircle, color: Colors.redAccent),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "You must complete all lectures before taking the test.",
                                          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        )
                      else
                        const Center(
                          child: Text(
                            "No test available for this course.",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }
}

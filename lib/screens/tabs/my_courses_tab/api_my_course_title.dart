import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../models/course_dto.dart';
import '../../../utils/custom_cached_image.dart';
import '../../course_details.dart/api_details_view.dart';

class ApiMyCourseTile extends StatelessWidget {
  final CourseDTO course;
  final int studentId;

  const ApiMyCourseTile({super.key, required this.course, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();

    final String buttonText = course.progress > 0 ? "Continue Course" : "Start Course";
    final Color buttonColor = course.progress > 0 ? Colors.blue : Colors.purple;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApiCourseDetailsView(
              courseId: course.id,
              studentId: studentId,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: 100,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
              child: Hero(
                tag: heroTag,
                child: CustomCacheImage(imageUrl: course.imageCover, radius: 3),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.titleCourse,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),

                  Text(
                    'By ${course.instructorFirstName} ${course.instructorLastName}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: course.progress / 100,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation(buttonColor),
                        minHeight: 6,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${course.progress}% completed',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: BorderSide(color: buttonColor),
                      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    child: Text(buttonText).tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApiCourseDetailsView(
                            courseId: course.id,
                            studentId: studentId,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

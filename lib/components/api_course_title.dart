import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lms_app/components/rating_bar.dart';
import 'package:lms_app/screens/course_details.dart/api_course_details_buy.dart';
import 'package:lms_app/utils/custom_cached_image.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../models/course_dto.dart';

class ApiCourseTile extends StatelessWidget {
  final CourseDTO course;

  const ApiCourseTile({super.key, required this.course});

  Future<int?> _getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('studentId');
  }

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();

    return FutureBuilder<int?>(
      future: _getStudentId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final studentId = snapshot.data!;

        return InkWell(
          onTap: () => NextScreen.iOS(
            context,
            ApiCourseDetailsBuy(courseId: course.id, studentId: studentId),
          ),
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
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
                        style: const TextStyle(color: Colors.blueAccent),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${course.categoryName}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 5),
                      RatingViewer(rating: 4.5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

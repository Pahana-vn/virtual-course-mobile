import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../models/course_dto.dart';

class ApiCourseInfo extends StatelessWidget {
  final CourseDTO course;

  const ApiCourseInfo({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Created By" + Tên giảng viên
          RichText(
            text: TextSpan(
              text: 'Created By ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '${course.instructorFirstName} ${course.instructorLastName}',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // TODO: Thêm chức năng mở hồ sơ giảng viên nếu cần
                    },
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Language
          Row(
            children: [
              const Icon(FeatherIcons.globe, size: 20, color: Colors.blueGrey),
              const SizedBox(width: 5),
              Text(
                "Language: English",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Category
          Row(
            children: [
              const Icon(FeatherIcons.bookmark, size: 20, color: Colors.blueGrey),
              const SizedBox(width: 5),
              Text(
                "Category: ${course.categoryName}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Level
          Row(
            children: [
              const Icon(FeatherIcons.trendingUp, size: 20, color: Colors.blueGrey),
              const SizedBox(width: 5),
              Text(
                "Level: ${course.level}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Duration
          Row(
            children: [
              const Icon(FeatherIcons.clock, size: 20, color: Colors.blueGrey),
              const SizedBox(width: 5),
              Text(
                "Duration: ${course.duration} hours",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

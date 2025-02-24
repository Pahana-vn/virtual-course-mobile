import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/components/html_body.dart';
import '../../models/course_dto.dart';

class ApiCourseDescription extends StatelessWidget {
  final CourseDTO course;

  const ApiCourseDescription({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: course.description != null && course.description.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề "Course Details"
            Text(
              'Course Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ).tr(),
            const SizedBox(height: 10),

            // Nội dung mô tả khóa học (HTML hỗ trợ)
            HtmlBody(description: course.description),
          ],
        ),
      ),
    );
  }
}

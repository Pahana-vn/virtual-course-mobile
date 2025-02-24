import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/course_dto.dart';
import '../../constants/custom_colors.dart';
import '../../components/rating_bar.dart';

class ApiTitleInfo extends ConsumerWidget {
  final CourseDTO course;

  const ApiTitleInfo({super.key, required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề khóa học
        Text(
          course.titleCourse,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 24,
            height: 1.5,
            wordSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // Rating & số lượng học viên
        Row(
          children: [
            RatingViewer(rating: 4.5),
            const SizedBox(width: 10),
            Text(
              '${course.progress} Students',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 15),

        // Mô tả ngắn gọn về nền tảng Virtual Course
        Text(
          "Welcome! Learn anywhere with expert-led courses, video lessons, and interactive assignments—just like Udemy & Coursera!",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            color: isDarkMode ? CustomColor.paragraphColorDark : CustomColor.paragraphColor,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

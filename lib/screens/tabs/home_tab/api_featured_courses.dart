import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';

import '../../../components/api_featured_course_tile.dart';
import '../../../providers/api_course_provider.dart';

class ApiFeaturedCourses extends ConsumerWidget {
  const ApiFeaturedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(allCoursesProvider);

    return courses.when(
      data: (courseDTOs) {
        if (courseDTOs.isEmpty) {
          return const Center(
            child: Text(
              "Không có khóa học nổi bật",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CarouselSlider(
            items: courseDTOs.map((courseDTO) {
              return ApiFeaturedCourseTile(courseDTO: courseDTO); // ✅ Sử dụng CourseDTO
            }).toList(),
            options: CarouselOptions(
              height: 300,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
              enlargeFactor: 0.2,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            ),
          ),
        );
      },
      error: (e, x) => Center(
        child: Text(
          'Lỗi khi tải khóa học: $e',
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
      loading: () => const LoadingTile(height: 260),
    );
  }
}

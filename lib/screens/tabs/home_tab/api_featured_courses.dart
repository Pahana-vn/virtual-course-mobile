import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/api_featured_course_tile.dart';
import '../../../providers/api_course_provider.dart';
import '../../course_details.dart/api_course_details_buy.dart';

class ApiFeaturedCourses extends ConsumerWidget {
  const ApiFeaturedCourses({super.key});

  Future<int?> _getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    final studentId = prefs.getInt('studentId');

    if (studentId != null) {
      return studentId;
    } else {
      const storage = FlutterSecureStorage();
      String? storedId = await storage.read(key: "studentId");

      if (storedId != null) {
        return int.tryParse(storedId);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(allCoursesProvider);

    return FutureBuilder<int?>(
      future: _getStudentId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("Error: Student ID not found"));
        }

        final studentId = snapshot.data!;

        return courses.when(
          data: (courseDTOs) {
            if (courseDTOs.isEmpty) {
              return const Center(
                child: Text(
                  "No featured courses",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider(
                items: courseDTOs.map((courseDTO) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApiCourseDetailsBuy(
                            courseId: courseDTO.id,
                            studentId: studentId,
                          ),
                        ),
                      );
                    },
                    child: ApiFeaturedCourseTile(courseDTO: courseDTO),
                  );
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
              'Error loading course: $e',
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          loading: () => const LoadingTile(height: 260),
        );
      },
    );
  }
}

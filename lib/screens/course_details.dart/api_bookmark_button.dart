import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/course_dto.dart';
import '../../providers/api_student_provider.dart';

class ApiBookmarkButton extends ConsumerWidget {
  final CourseDTO course;

  const ApiBookmarkButton({super.key, required this.course});

  Future<int?> _getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('studentId');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<int?>(
      future: _getStudentId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Icon(Icons.favorite_border, color: Colors.grey);

        final studentId = snapshot.data!;
        final wishlist = ref.watch(wishlistProvider(studentId));

        return wishlist.when(
          data: (wishlistCourses) {
            final isFavorite = wishlistCourses.any((c) => c.id == course.id);
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.redAccent : Colors.grey,
              ),
              onPressed: () async {
                final apiService = ref.read(apiStudentServiceProvider);
                if (isFavorite) {
                  await apiService.removeFromWishlist(studentId, course.id);
                } else {
                  await apiService.addToWishlist(studentId, course);
                }
                ref.invalidate(wishlistProvider(studentId)); // Refresh danh sách wishlist
              },
            );
          },
          loading: () => const Icon(Icons.favorite_border, color: Colors.grey),
          error: (_, __) => const Icon(Icons.favorite_border, color: Colors.grey),
        );
      },
    );
  }
}

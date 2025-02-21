import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/models/course_dto.dart';
import 'package:lms_app/screens/course_details.dart/api_details_view.dart'; // ✅ Sử dụng API-based CourseDetailsView
import 'package:lms_app/utils/next_screen.dart';
import 'rating_bar.dart';

class ApiHorizontalCourseTile extends StatelessWidget {
  const ApiHorizontalCourseTile({
    super.key,
    required this.courseDTO,
    required this.widthPercentage,
    required this.imageHeight,
  });

  final CourseDTO courseDTO; // ✅ Dùng CourseDTO thay vì Course
  final double widthPercentage;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();

    return InkWell(
      // onTap: () => NextScreen.iOS(
      //   context,
      //   ApiDetailsView(courseDTO: courseDTO, heroTag: heroTag), // ✅ Sử dụng ApiDetailsView thay vì CourseDetailsView
      // ),
      child: Container(
        width: MediaQuery.of(context).size.width * widthPercentage,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: imageHeight,
                  width: MediaQuery.of(context).size.width,
                  child: Hero(
                    tag: heroTag,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        courseDTO.imageCover, // ✅ Kiểm tra với Image.network
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print("Error loading image: $error"); // ✅ Debug lỗi
                          return Image.asset('assets/images/placeholder.png', fit: BoxFit.cover);
                        },
                      ),
                    ),

                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              courseDTO.titleCourse, // ✅ Dùng titleCourse từ CourseDTO
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            Text(
              '${courseDTO.instructorFirstName} ${courseDTO.instructorLastName}', // ✅ Hiển thị instructor
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 3),
            Text(
              courseDTO.categoryName, // ✅ Hiển thị danh mục
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
            ),
            const SizedBox(height: 3),
            const RatingViewer(rating: 4.5), // ✅ Hiện tại rating chưa có trong API
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lms_app/models/course_dto.dart';
import 'rating_bar.dart';

class ApiHorizontalCourseTile extends StatelessWidget {
  const ApiHorizontalCourseTile({
    super.key,
    required this.courseDTO,
    required this.widthPercentage,
    required this.imageHeight,
  });

  final CourseDTO courseDTO;
  final double widthPercentage;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();

    return InkWell(
      // onTap: () => NextScreen.iOS(
      //   context,
      //   ApiDetailsView(courseDTO: courseDTO, heroTag: heroTag),
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
                        courseDTO.imageCover,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print("Error loading image: $error");
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
              courseDTO.titleCourse,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            Text(
              '${courseDTO.instructorFirstName} ${courseDTO.instructorLastName}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 3),
            Text(
              courseDTO.categoryName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
            ),
            const SizedBox(height: 3),
            const RatingViewer(rating: 4.5),
          ],
        ),
      ),
    );
  }
}

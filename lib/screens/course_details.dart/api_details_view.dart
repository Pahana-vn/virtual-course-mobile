// import 'package:feather_icons/feather_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lms_app/ads/ad_manager.dart';
// import 'package:lms_app/ads/banner_ad.dart';
// import 'package:lms_app/screens/course_details.dart/course_share_button.dart';
// import 'bookmark_button.dart'; // ✅ Thay BookmarkButton bằng ApiBookmarkButton
// import '../../models/course_dto.dart'; // ✅ Dùng CourseDTO thay vì Course
// import 'course_description.dart';
// import 'course_info.dart';
// import 'course_reviews.dart';
// import 'course_tags.dart';
// import 'curriculam.dart';
// import 'enroll_button.dart';
// import 'learnings.dart';
// import 'preview_box.dart';
// import 'related_courses.dart';
// import 'requirements.dart';
// import 'review_button.dart';
// import 'title_info.dart';
//
// class ApiDetailsView extends ConsumerWidget {
//   const ApiDetailsView({super.key, required this.courseDTO, this.heroTag});
//
//   final CourseDTO courseDTO; // ✅ Dùng CourseDTO
//   final Object? heroTag;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       bottomNavigationBar: Wrap(
//         alignment: WrapAlignment.center,
//         children: [
//           AdManager.isBannerEnbaled(ref) ? const BannerAdWidget() : Container(),
//           EnrollButton(courseDTO: courseDTO), // ✅ Truyền nguyên `CourseDTO`
//         ],
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             pinned: false,
//             floating: true,
//             leading: IconButton(
//               onPressed: () => Navigator.pop(context),
//               icon: const Icon(FeatherIcons.chevronLeft),
//             ),
//             actions: [
//               BookmarkButton(courseDTO: courseDTO),
//               ReviewButton(courseDTO: courseDTO),
//               CourseShareButton(courseDTO: courseDTO),
//               const SizedBox(width: 10),
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   PreviewBox(imageUrl: courseDTO.imageCover, heroTag: heroTag), // ✅ Dùng `imageCover`
//                   const SizedBox(height: 20),
//                   TitleInfo(title: courseDTO.titleCourse),
//                   CourseInfo(level: courseDTO.level, category: courseDTO.categoryName),
//                   Learnings(description: courseDTO.description), // ✅ Sử dụng mô tả từ CourseDTO
//                   const SizedBox(height: 40),
//                   Curriculam(courseId: courseDTO.id), // ✅ Dùng ID của khóa học
//                   Requirements(requirements: "Updating..."), // ✅ Hiện tại chưa có requirements từ API
//                   CourseDescription(description: courseDTO.description),
//                   CourseTags(tags: ["IT", "Development"]), // ✅ Gán tạm một số tag
//                   RelatedCourses(categoryId: courseDTO.categoryId), // ✅ Load khóa học liên quan theo category
//                   CourseReviews(courseId: courseDTO.id), // ✅ Load đánh giá
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

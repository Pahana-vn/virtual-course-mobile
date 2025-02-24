import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/course_dto.dart';
import '../../utils/custom_cached_image.dart';
import '../../utils/next_screen.dart';
import '../video_player_screen.dart';

class ApiPreviewBox extends StatelessWidget {
  const ApiPreviewBox({
    super.key,
    required this.course,
  });

  final CourseDTO course;

  @override
  Widget build(BuildContext context) {
    final bool hasVideoPreview = course.urlVideo != null && course.urlVideo!.isNotEmpty;

    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: () {
            if (hasVideoPreview) {
              NextScreen.iOS(context, VideoPlayerScreen(videoUrl: course.urlVideo!));
            }
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            width: double.infinity,
            child: hasVideoPreview
                ? CustomCacheImage(imageUrl: course.imageCover, radius: 5)
                : CustomCacheImage(imageUrl: course.imageCover, radius: 5),
          ),
        ),
        Visibility(
          visible: hasVideoPreview,
          child: const Align(
            alignment: Alignment.center,
            child: IgnorePointer(
              child: Icon(
                CupertinoIcons.play,
                size: 45,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

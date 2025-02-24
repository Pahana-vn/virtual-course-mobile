import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '../../models/section_dto.dart';
import '../video_player_screen.dart';

class ApiSections extends StatelessWidget {
  final SectionDTO section;

  const ApiSections({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        section.titleSection,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      children: section.lectures
          .where((lecture) => lecture.lectureVideo.isNotEmpty)
          .map((lecture) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị articles nếu có
          if (lecture.articles.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lecture.articles.map((article) => ListTile(
                  leading: const Icon(FeatherIcons.fileText), // Biểu tượng cho article
                  title: Text(article.content),
                  subtitle: Text("File: ${article.fileUrl}"),
                  onTap: () {
                    // Xử lý khi bấm vào article (ví dụ: mở file PDF)
                    print("Opening article: ${article.fileUrl}");
                  },
                )).toList(),
              ),
            ),
          // Hiển thị lecture
          ListTile(
            leading: Icon(
              FeatherIcons.playCircle,
              color: lecture.completed ? Colors.green : Colors.blue,
            ),
            title: Text(lecture.titleLecture),
            subtitle: Text("Lecture: ${lecture.lectureOrder}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoUrl: lecture.lectureVideo),
                ),
              );
            },
          ),
        ],
      ))
          .toList(),
    );
  }
}
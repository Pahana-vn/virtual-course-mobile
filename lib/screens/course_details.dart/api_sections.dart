import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '../../models/section_dto.dart';
import '../video_player_screen.dart';

class ApiSections extends StatelessWidget {
  final SectionDTO section;
  final int index;

  const ApiSections({super.key, required this.section, required this.index});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "${index + 1}. ${section.titleSection}",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      children: section.lectures.expand((lecture) {
        return [
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
          ...lecture.articles.map((article) => ListTile(
            leading: const Icon(FeatherIcons.fileText),
            title: const Text("Document"),
            subtitle: Text("File: ${article.fileUrl}"),
            onTap: () {
              print("Opening article: ${article.fileUrl}");
            },
          )),
        ];
      }).toList(),
    );
  }
}
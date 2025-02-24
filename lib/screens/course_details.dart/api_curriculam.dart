import 'package:flutter/material.dart';
import '../../models/course_dto.dart';
import 'api_sections.dart';

class ApiCurriculam extends StatelessWidget {
  final CourseDTO course;

  const ApiCurriculam({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    if (course.sections.isEmpty) {
      return const Center(child: Text("No sections available"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Curriculum',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: course.sections.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12, width: 1.5),
                ),
                child: ApiSections(section: course.sections[index], index: index),
              ),
            );
          },
        ),
      ],
    );
  }
}
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lms_app/constants/custom_colors.dart';
import 'package:lms_app/services/app_service.dart';

class ApiLearnings extends StatelessWidget {
  const ApiLearnings({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> learnings = [
      "Understand the basics of UX design",
      "Learn wireframing and prototyping",
      "Gain knowledge of user research methods",
      "Master usability testing techniques"
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      color: AppService.isDarkMode(context) ? CustomColor.containerDark : CustomColor.container,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề
          Text(
            'What will you learn',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ).tr(),
          const SizedBox(height: 10),

          // Danh sách học tập (Sử dụng ListView.builder để tránh lỗi tràn màn hình)
          ListView.builder(
            shrinkWrap: true, // ✅ Ngăn ListView chiếm hết không gian
            physics: const NeverScrollableScrollPhysics(), // ✅ Tránh cuộn lồng nhau
            itemCount: learnings.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 10,
                title: Text(learnings[index]),
                leading: const Icon(FeatherIcons.check, color: Colors.blue),
              );
            },
          ),
        ],
      ),
    );
  }
}

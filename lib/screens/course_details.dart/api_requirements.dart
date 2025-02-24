import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ApiRequirements extends StatelessWidget {
  const ApiRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> requirements = [
      "No programming experience is required",
      "Access to both a computer and smartphone would be beneficial",
      "Basic computer skills: surfing websites, running programs, saving and opening documents, etc"
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề "Requirements"
          Text(
            'Requirements',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ).tr(),
          const SizedBox(height: 10),

          // Danh sách yêu cầu
          Column(
            children: requirements
                .map((e) => ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 10,
              title: Text(e),
              leading: const Icon(FeatherIcons.check, color: Colors.blueAccent),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

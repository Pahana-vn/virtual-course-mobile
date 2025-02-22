import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/instructor_dto.dart';
import '../utils/next_screen.dart';
import '../screens/author_profie/author_profile.dart';
import '../components/user_avatar.dart';
import '../constants/custom_colors.dart';
import '../services/app_service.dart';

class ApiAuthorCard extends StatelessWidget {
  final InstructorDTO instructor;
  const ApiAuthorCard({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    final String fullName = '${instructor.firstName} ${instructor.lastName}';
    final String jobTitle = instructor.title ?? '';
    final String bio = instructor.bio ?? '';

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppService.isDarkMode(context) ? CustomColor.borderDark : CustomColor.border),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(imageUrl: instructor.photo ?? '', radius: 40),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 18)),
                    Text(jobTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith()),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(bio,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppService.isDarkMode(context) ? CustomColor.paragraphColorDark : CustomColor.paragraphColor,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(elevation: 0, side: BorderSide(color: Theme.of(context).primaryColor)),
              // onPressed: () => NextScreen.iOS(context, AuthorProfile(instructor: instructor)),
              onPressed: null, // Nút sẽ bị vô hiệu hóa
              child: const Text('view-profile').tr(),
            ),
          )
        ],
      ),
    );
  }
}

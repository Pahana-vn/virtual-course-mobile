import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/all_courses.dart/courses_view.dart';
import 'package:lms_app/utils/custom_cached_image.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../models/category_dto.dart';

class CategoriesLayout2 extends ConsumerWidget {
  final AsyncValue<List<CategoryDTO>> categories;

  const CategoriesLayout2({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'all-categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ).tr(),
          const SizedBox(height: 10),
          categories.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            data: (data) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: data.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final CategoryDTO category = data[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    title: Text(category.name),
                    titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    trailing: const Icon(FeatherIcons.chevronRight),
                    leading: SizedBox(
                      height: 40,
                      width: 50,
                      child: CustomCacheImage(
                        imageUrl: category.image ?? 'https://via.placeholder.com/50',
                        radius: 3,
                      ),
                    ),
                    onTap: () => NextScreen.iOS(
                      context,
                      AllCoursesView(
                        courseBy: CourseBy.category,
                        title: category.name,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

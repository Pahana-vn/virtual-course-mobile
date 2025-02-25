import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/screens/all_courses.dart/courses_view.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../models/category_dto.dart';
import '../../../providers/api_category_provider.dart';
import '../../home/home_bottom_bar.dart';
import '../../home/home_view.dart';

class ApiHomeCategories extends ConsumerWidget {
  const ApiHomeCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(allCategoriesProvider);

    return categories.when(
      skipLoadingOnRefresh: false,
      data: (List<CategoryDTO> categories) {
        if (categories.isEmpty) return const SizedBox();

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'categories',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ).tr(),
                  TextButton(
                    onPressed: () {
                      ref.read(navBarIndexProvider.notifier).state = 1;
                      ref.read(homeTabControllerProvider.notifier).state.animateToPage(
                          1, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
                    },
                    style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    child: Text(
                      'view-all',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories
                    .take(5)
                    .map((CategoryDTO category) => ActionChip(
                  onPressed: () => NextScreen.iOS(
                    context,
                    AllCoursesView(courseBy: CourseBy.category, title: category.name, categoryId: category.id.toString()),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  label: Text(
                    category.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ))
                    .toList(),
              ),
            ],
          ),
        );
      },
      error: (e, x) => Center(child: Text('Error loading categories: $e')),
      loading: () => const LoadingTile(height: 100, padding: 0),
    );
  }
}

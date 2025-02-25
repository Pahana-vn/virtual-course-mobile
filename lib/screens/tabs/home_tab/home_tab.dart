import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/components/app_logo.dart';
import 'package:lms_app/screens/tabs/home_tab/top_authors.dart';
import 'package:lms_app/screens/notifications/notifications.dart';
import 'package:lms_app/screens/wishlist.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../providers/app_settings_provider.dart';
import '../../search/api_search_view.dart';
import 'api_category1_courses.dart';
import 'api_category2_courses.dart';
import 'api_category3_courses.dart';
import 'api_featured_courses.dart';
import 'api_free_courses.dart';
import 'api_home_categories.dart';
import 'api_top_authors.dart';
import 'category1_courses.dart';
import 'category2_courses.dart';
import 'category3_courses.dart';
import 'featured_courses.dart';
import 'free_courses.dart';
import 'home_categories.dart';
import 'home_latest_courses.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    return RefreshIndicator.adaptive(
      displacement: 60,
      onRefresh: () async {
        ref.invalidate(featuredCoursesProvider);
        ref.invalidate(homeCategoriesProvider);
        ref.invalidate(freeCoursesProvider);
        ref.invalidate(category1CoursessProvider);
        ref.invalidate(category2CoursessProvider);
        ref.invalidate(category3CoursessProvider);
        ref.invalidate(topAuthorsProvider);
        ref.invalidate(homeLatestCoursesProvider);
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const AppLogo(),
            pinned: false,
            floating: true,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                // style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: () {
                  NextScreen.iOS(context, const ApiSearchScreen());
                },
                icon: const Icon(FeatherIcons.search, size: 22),
              ),
              IconButton(
                style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: () {
                  NextScreen.iOS(context, const Wishlist());
                },
                icon: const Icon(FeatherIcons.heart, size: 22),
              ),
              IconButton(
                // style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: () {
                  NextScreen.iOS(context, const Notifications());
                },
                icon: const Icon(LineIcons.bell),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Visibility(visible: settings?.featured ?? true, child: const ApiFeaturedCourses()),
                Visibility(visible: settings?.categories ?? true, child: const ApiHomeCategories()),
                Visibility(visible: settings?.freeCourses ?? true, child: const ApiFreeCourses()),
                const ApiCategory1Courses(),
                const ApiCategory2Courses(),
                const ApiCategory3Courses(),
                Visibility(visible: settings?.topAuthors ?? true, child: const ApiTopAuthors()),
                // Visibility(visible: settings?.latestCourses ?? true, child: const HomeLatestCourses()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

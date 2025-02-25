import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/search/recent_searches.dart';
import 'package:lms_app/screens/search/search_bar.dart';

import '../../utils/empty_icon.dart';
import 'api_searched_courses.dart';

final searchTextCtlrProvider = StateProvider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
);

final searchStartedProvider = StateProvider.autoDispose<bool>((ref) => false);
final recentSearchDataProvider = StateProvider<List<String>>((ref) => []);

class ApiSearchScreen extends ConsumerStatefulWidget {
  const ApiSearchScreen({super.key});

  @override
  ConsumerState<ApiSearchScreen> createState() => _ApiSearchScreenState();
}

class _ApiSearchScreenState extends ConsumerState<ApiSearchScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        ref.read(searchStartedProvider.notifier).state = true;
        ref.read(searchTextCtlrProvider.notifier).state.text = searchController.text; // Cập nhật searchTextCtlrProvider
      } else {
        ref.read(searchStartedProvider.notifier).state = false;
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool searchStarted = ref.watch(searchStartedProvider);
    final recentSearchList = ref.watch(recentSearchDataProvider);

    print("🔍 [LOG] Search started: $searchStarted");

    Widget buildView() {
      final bool searchStarted = ref.watch(searchStartedProvider);
      final recentSearchList = ref.watch(recentSearchDataProvider);

      if (searchStarted) {
        print("🔍 [LOG] Searching for courses...");
        return const ApiSearchedCourses();
      } else {
        if (recentSearchList.isNotEmpty) {
          print("📜 [LOG] Showing recent searches...");
          return const RecentSearches();
        } else {
          print("🔍 [LOG] Waiting for user to type search query...");
          return EmptyPageWithIcon(icon: FeatherIcons.search, title: 'search-course'.tr());
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: const SearchAppBar(),
        leading: IconButton(
          icon: const Icon(FeatherIcons.chevronLeft),
          onPressed: () {
            print("🔙 [LOG] User exited search screen");
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 5),
          Expanded(child: buildView()),
        ],
      ),
    );
  }
}



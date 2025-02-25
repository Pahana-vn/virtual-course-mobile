import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/utils/snackbars.dart';

import 'api_search_view.dart';

class SearchAppBar extends ConsumerWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTextCtlr = ref.watch(searchTextCtlrProvider);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: TextFormField(
        autofocus: true,
        controller: searchTextCtlr,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "search-course".tr(),
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(right: 10),
            icon: Icon(
              Icons.close,
              size: 22,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              ref.read(searchTextCtlrProvider.notifier).state = TextEditingController();
              ref.read(searchStartedProvider.notifier).state = false;
            },
          ),
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          print("[LOG] User is typing: $value");
        },
        onFieldSubmitted: (value) {
          final trimmedValue = value.trim();

          if (trimmedValue.isEmpty) {
            print("The user presses Enter but enters nothing.");
            openSnackbar(context, 'Please enter search keywords!');
            return;
          }

          print("User enters keyword: $trimmedValue");

          ref.read(searchTextCtlrProvider.notifier).state = TextEditingController(text: trimmedValue);

          final history = ref.read(recentSearchDataProvider);
          final newHistory = [trimmedValue, ...history];

          ref.read(recentSearchDataProvider.notifier).state = newHistory.take(10).toList();

          ref.read(searchStartedProvider.notifier).state = true;
        },
      ),
    );
  }
}

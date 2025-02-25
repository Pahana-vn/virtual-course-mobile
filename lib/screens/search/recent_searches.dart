import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_search_view.dart';

class RecentSearches extends ConsumerWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearches = ref.watch(recentSearchDataProvider).reversed.toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search history',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ).tr(),
          const SizedBox(height: 15),
          if (recentSearches.isEmpty)
            Center(
              child: Text(
                "No search history",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recentSearches
                  .map(
                    (e) => ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(e),
                  leading: const Icon(CupertinoIcons.time, color: Colors.blueGrey),
                  trailing: IconButton(
                    icon: const Icon(FeatherIcons.delete, size: 20),
                    onPressed: () {
                      final updatedHistory = ref.read(recentSearchDataProvider).where((item) => item != e).toList();
                      ref.read(recentSearchDataProvider.notifier).state = updatedHistory;
                    },
                  ),
                  onTap: () {
                    ref.read(searchTextCtlrProvider.notifier).state.text = e;
                    ref.read(searchStartedProvider.notifier).state = true;
                  },
                ),
              )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

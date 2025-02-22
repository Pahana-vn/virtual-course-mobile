import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/api_author_card.dart';
import '../../../components/loading_tile.dart';
import '../../../providers/api_instructor_provider.dart';

class ApiTopAuthors extends ConsumerWidget {
  const ApiTopAuthors({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final instructors = ref.watch(apiTopAuthorsProvider);

    return instructors.when(
      data: (data) {
        return Visibility(
          visible: data.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Instructors',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {}, // TODO: Thêm màn hình hiển thị tất cả instructors
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.map((instructor) => ApiAuthorCard(instructor: instructor)).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (e, _) => Text('Error: $e'),
      loading: () => const LoadingTile(height: 300),
    );
  }
}

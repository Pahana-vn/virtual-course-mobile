import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/api_user_provider.dart';
import '../../../models/api_user_model.dart';
import 'api_user_info.dart';
import 'guest_user.dart';
import 'user_info.dart';
import 'settings.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(apiUserProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('profile'),
          pinned: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                user != null
                    ? ApiUserInfo(user: user) // Hiển thị user info nếu có
                    : const GuestUser(), // Nếu user chưa load, hiển thị login
                const AppSettings(),
              ],
            ),
          ),
        )
      ],
    );
  }
}


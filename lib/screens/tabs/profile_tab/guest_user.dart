import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/api_user_provider.dart';
import '../../../utils/api_next_screen.dart'; // Import file mới
import '../../auth/login.dart';

class GuestUser extends ConsumerWidget {
  const GuestUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 0.3, color: Colors.blueGrey), borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: const Text('login'),
        leading: const Icon(Icons.person_add),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          final studentId = await ApiNextScreen.openBottomSheet(context, const LoginScreen(popUpScreen: true));

          if (studentId != null) {
            print("✅ Fetching user with studentId: $studentId");
            await ref.read(apiUserProvider.notifier).fetchUser(studentId); // Gọi API lấy user

            // Kiểm tra xem có load dữ liệu user đúng không
            final user = ref.read(apiUserProvider);
            if (user != null) {
              print("🎉 User loaded: ${user.username}, ${user.email}");
            } else {
              print("❌ Failed to load user data!");
            }
          }
        },
      ),
    );
  }
}



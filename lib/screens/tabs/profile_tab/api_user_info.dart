import 'package:flutter/material.dart';
import '../../../models/api_user_model.dart';

class ApiUserInfo extends StatelessWidget {
  const ApiUserInfo({super.key, required this.user});

  final ApiUserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          title: Text(
            user.username,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          subtitle: Text(user.email),
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbSbfQH0ngGM1xnavF0vZOaHdv8Cvc2FP4Wg&s",
            ), // Luôn sử dụng ảnh mặc định
            backgroundColor: Colors.grey[400], // Màu nền nếu ảnh bị lỗi
          ),
          trailing: const Icon(Icons.edit),
        ),
      ],
    );
  }
}

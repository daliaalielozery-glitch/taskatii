import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/features/auth/models/user_model.dart';

class HomeAppBar extends StatelessWidget {
  final Box<UserModel> box;
  const HomeAppBar({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box<UserModel> box, _) {
        final user = box.isNotEmpty ? box.getAt(0) : null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, ${user?.name ?? "User"}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Have A Nice Day.",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.pinkAccent,
              backgroundImage: user != null && user.image.isNotEmpty
                  ? FileImage(File(user.image))
                  : null,
            ),
          ],
        );
      },
    );
  }
}

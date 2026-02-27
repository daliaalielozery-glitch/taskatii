import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/features/auth/models/user_model.dart';
import 'package:to_do_list/features/update_profile/update_profile_screen.dart'; // import your update screen

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

            // Make profile pic clickable
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UpdateProfileScreen()),
                );
              },
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.pinkAccent,
                backgroundImage: user != null && user.image.isNotEmpty
                    ? FileImage(File(user.image))
                    : null,
                child: user == null || user.image.isEmpty
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

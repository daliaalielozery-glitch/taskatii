import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/core/app_constants.dart';
import 'package:to_do_list/features/add_task/add_task_screen.dart';
import 'package:to_do_list/features/auth/models/user_model.dart';
import 'package:to_do_list/features/home/widgets/add_task.dart';
import 'package:to_do_list/features/home/widgets/date_row.dart';
import 'package:to_do_list/features/home/widgets/home_app_bar.dart';
import 'package:to_do_list/features/home/widgets/tasks_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box<UserModel>(AppConstants.userBox);

    return Scaffold(
      backgroundColor: const Color(0xffF4F5F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(box: box),

              const SizedBox(height: 20),
              //
              AddTask(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddTaskScreen()),
                  );

                  if (result != null && result == true) {
                    setState(() {});
                  }
                },
              ),

              const SizedBox(height: 16),
              //DATE
              DateRow(),

              const SizedBox(height: 16),

              TasksListView(),
            ],
          ),
        ),
      ),
    );
  }
}

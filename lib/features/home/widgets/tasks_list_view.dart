import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/core/app_constants.dart';
import 'package:to_do_list/features/home/models/task_model.dart';
import 'package:to_do_list/features/home/widgets/task_card.dart';

class TasksListView extends StatelessWidget {
  final int activeIndex;

  const TasksListView({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<TaskModel>(AppConstants.taskBox).listenable(),
      builder: (context, Box<TaskModel> box, _) {
        List<TaskModel> tasks = box.values.toList();

        if (activeIndex == 1) {
          tasks = tasks
              .where((e) => e.stausText.toLowerCase() == 'todo')
              .toList();
        } else if (activeIndex == 2) {
          tasks = tasks
              .where((e) => e.stausText.toLowerCase() == 'complete')
              .toList();
        }

        if (tasks.isEmpty) {
          return Center(child: Lottie.asset("assets/empty_task.json"));
        }

        return ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return TaskCard(task: tasks[index]);
          },
        );
      },
    );
  }
}

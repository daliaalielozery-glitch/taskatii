import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/features/home/models/task_model.dart';
import 'package:to_do_list/features/home/widgets/task_card.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return allTasks.isEmpty
        ? Lottie.asset("assets/empty_task.json")
        : Expanded(
            child: ListView.separated(
              itemCount: allTasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final task = allTasks[index];
                return TaskCard(task: task);
              },
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/core/app_constants.dart';
import 'package:to_do_list/features/auth/models/user_model.dart';
import 'package:to_do_list/features/home/models/task_model.dart';
import 'package:to_do_list/todo_app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());

  await Hive.openBox<UserModel>(AppConstants.userBox);
  await Hive.openBox<TaskModel>(AppConstants.taskBox);
  runApp(TodoApp());
}

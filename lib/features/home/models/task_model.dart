import 'package:flutter/material.dart';

class TaskModel {
  String title;
  String startTime;
  String endTime;
  String stausText;
  String description;
  Color color;

  TaskModel({
    required this.title,
    required this.description,
    required this.color,
    required this.endTime,
    required this.startTime,
    required this.stausText,
  });
}

final List<TaskModel> allTasks = [];

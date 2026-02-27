import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String startTime;
  @HiveField(2)
  String endTime;
  @HiveField(3)
  String stausText;
  @HiveField(4)
  String description;
  @HiveField(5)
  int color;

  TaskModel({
    required this.title,
    required this.description,
    required this.color,
    required this.endTime,
    required this.startTime,
    required this.stausText,
  });

  // Future<void> save() async {}
}

List<TaskModel> allTasks = [];

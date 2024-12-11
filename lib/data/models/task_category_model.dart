import 'package:hive/hive.dart';
import 'package:subul_g1_todo_app/data/models/task_model.dart';

part 'task_category_model.g.dart';

@HiveType(typeId: 0)
class TaskCategoryModel {
  @HiveField(0)
  final String category;

  @HiveField(1)
  final List<TaskModel> data;

  TaskCategoryModel({
    required this.category,
    required this.data,
  });
}

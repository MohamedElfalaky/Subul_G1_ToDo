import 'package:hive/hive.dart';
import 'task_model.dart';

part 'task_category_model.g.dart'; // Make sure to generate this file using build_runner

@HiveType(typeId: 1)
class TaskCategoryModel {
  @HiveField(0)
  String category;

  @HiveField(1)
  List<TaskModel> data;

  TaskCategoryModel({
    required this.category,
    required this.data,
  });
}

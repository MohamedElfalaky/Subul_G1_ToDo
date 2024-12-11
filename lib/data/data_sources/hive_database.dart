import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:subul_g1_todo_app/data/models/hive_models/task_category_model.dart';
import 'package:subul_g1_todo_app/data/models/hive_models/task_model.dart';

class HiveDatabase {
  static final HiveDatabase _instance = HiveDatabase._private();

  HiveDatabase._private();

  factory HiveDatabase() {
    return _instance;
  }

  // Box for storing Task Categories
  Box<TaskCategoryModel>? _taskCategoryBox;

  // Initialize the box
  Future<void> init() async {
    final docDir = await getApplicationDocumentsDirectory();
    Hive.init(docDir.path);
    // Register adapters if not already registered
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(TaskCategoryModelAdapter());

    _taskCategoryBox = await Hive.openBox<TaskCategoryModel>('taskCategories');
    if (_taskCategoryBox!.isEmpty) {
      _taskCategoryBox!.addAll([
        TaskCategoryModel(category: 'Todo', data: []),
        TaskCategoryModel(category: 'Done', data: []),
        TaskCategoryModel(category: 'Deleted', data: []),
      ]);
    }
  }

  // Get categories data from Hive
  List<TaskCategoryModel> getCategories() {
    return _taskCategoryBox!.values.toList();
  }

  // Adding new task
  Future<void> addTask(
    TaskModel task,
  ) async {
    // Check if category already exists
    TaskCategoryModel? toDoCategory = _taskCategoryBox?.values.toList()[0];

    if (toDoCategory != null) {
      toDoCategory.data.add(task);
      // Update the category in the box by putting the modified object
      await _taskCategoryBox?.putAt(0, toDoCategory);
    }
  }

  // Edit task
  Future<void> editTask(
    TaskModel oldTask,
    TaskModel newTask,
  ) async {
    // Check if category already exists
    TaskCategoryModel? toDoCategory = _taskCategoryBox?.values.toList()[0];

    if (toDoCategory != null) {
      toDoCategory.data.remove(oldTask);
      toDoCategory.data.add(newTask);

      // Update the category in the box by putting the modified object
      await _taskCategoryBox?.putAt(0, toDoCategory);
    }
  }

  // done task
  Future<void> moveToDone(
    TaskModel task,
  ) async {
    // Check if category already exists
    TaskCategoryModel? todoCategory = _taskCategoryBox?.values.toList()[0];
    TaskCategoryModel? doneCategory = _taskCategoryBox?.values.toList()[1];

    if (doneCategory != null && todoCategory != null) {
      todoCategory.data.remove(task);
      doneCategory.data.add(task);

      await _taskCategoryBox?.putAt(0, todoCategory);
      await _taskCategoryBox?.putAt(1, doneCategory);
    }
  }

  // undo task
  Future<void> unDoTask(
    TaskModel task,
  ) async {
    // Check if category already exists
    TaskCategoryModel? todoCategory = _taskCategoryBox?.values.toList()[0];
    TaskCategoryModel? doneCategory = _taskCategoryBox?.values.toList()[1];

    if (doneCategory != null && todoCategory != null) {
      doneCategory.data.remove(task);
      todoCategory.data.add(task);

      await _taskCategoryBox?.putAt(0, todoCategory);
      await _taskCategoryBox?.putAt(1, doneCategory);
    }
  }

  // delete task
  Future<void> deleteTask(
    TaskModel task,
  ) async {
    // Check if category already exists
    TaskCategoryModel? todoCategory = _taskCategoryBox?.values.toList()[0];
    TaskCategoryModel? deleteCategory = _taskCategoryBox?.values.toList()[2];

    if (deleteCategory != null && todoCategory != null) {
      todoCategory.data.remove(task);
      deleteCategory.data.add(task);

      await _taskCategoryBox?.putAt(0, todoCategory);
      await _taskCategoryBox?.putAt(2, deleteCategory);
    }
  }

  // unDelete task
  Future<void> unDeleteTask(
    TaskModel task,
  ) async {
    // Check if category already exists
    TaskCategoryModel? todoCategory = _taskCategoryBox?.values.toList()[0];
    TaskCategoryModel? deleteCategory = _taskCategoryBox?.values.toList()[2];

    if (deleteCategory != null && todoCategory != null) {
      todoCategory.data.add(task);
      deleteCategory.data.remove(task);

      await _taskCategoryBox?.putAt(0, todoCategory);
      await _taskCategoryBox?.putAt(2, deleteCategory);
    }
  }
}

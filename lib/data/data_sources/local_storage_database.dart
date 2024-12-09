import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    await Hive.initFlutter();
    // Register adapters if not already registered
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(TaskCategoryModelAdapter());

    _taskCategoryBox = await Hive.openBox<TaskCategoryModel>('taskCategories');
  }

  // Save categories data to Hive
  Future<void> saveCategories(List<TaskCategoryModel> categoriesList) async {
    for (var category in categoriesList) {
      await _taskCategoryBox?.add(category);
    }
  }

  // Get categories data from Hive
  List<TaskCategoryModel> getCategories() {
    return _taskCategoryBox?.values.toList() ?? [];
  }

  // Adding new task
  Future<void> addTask(TaskModel task, String category) async {
    // Check if category already exists
    TaskCategoryModel? existingCategory = _taskCategoryBox?.values.firstWhere(
      (cat) => cat.category == category,
      orElse: () => TaskCategoryModel(category: category, data: []),
    );

    if (existingCategory != null) {
      existingCategory.data.add(task);
      // Update the category in the box by putting the modified object
      await _taskCategoryBox?.put(category, existingCategory);
    }
  }

  // Delete task
  Future<void> deleteTask(int index, String category) async {
    TaskCategoryModel? categoryData = _taskCategoryBox?.values.firstWhere(
      (cat) => cat.category == category,
    );

    if (categoryData != null) {
      categoryData.data.removeAt(index);
      // Update the category in the box by putting the modified object
      await _taskCategoryBox?.put(category, categoryData);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:subul_g1_todo_app/data/models/task_model.dart';

class LocalVariablesDatabase {
  static final LocalVariablesDatabase _instance =
      LocalVariablesDatabase._private();

  LocalVariablesDatabase._private();

  factory LocalVariablesDatabase() {
    return _instance;
  }

  List<TaskCategoryModel> categoriesList = [
    TaskCategoryModel(category: 'ToDo', data: [
      TaskModel(
          title: 'go to gym',
          body: 'i must go to the gym today',
          color: Colors.blue,
          date: '04/12',
          time: '10:00 PM'),
      TaskModel(
          title: 'test',
          body: 'test test',
          color: Colors.red,
          date: '04/12',
          time: '10:00 PM'),
    ]),
    TaskCategoryModel(category: 'Done', data: []),
    TaskCategoryModel(category: 'Deleted', data: [
      TaskModel(
          title: 'test',
          body: 'test test',
          color: Colors.green,
          date: '04/12',
          time: '10:00 PM'),
    ]),
    TaskCategoryModel(category: 'All', data: []),
  ];
}

import 'package:flutter/material.dart';
import 'package:subul_g1_todo_app/data/models/task_category_model.dart';
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
          color: 0xFFFFFF00,
          date: '04/12',
          time: '10:00 PM'),
      TaskModel(
          title: 'test',
          body: 'test test',
          color: 0xFFFFFF70,
          date: '04/12',
          time: '10:00 PM'),
    ]),
    TaskCategoryModel(category: 'Done', data: [
      TaskModel(
          title: 'test',
          body: 'test test',
          color: 0xFFFFFF30,
          date: '04/12',
          time: '10:00 PM'),
    ]),
    TaskCategoryModel(category: 'Deleted', data: [
      TaskModel(
          title: 'test',
          body: 'test test',
          color: 0xFFFFFF00,
          date: '04/12',
          time: '10:00 PM'),
    ]),
    // TaskCategoryModel(category: 'All', data: [
    //   TaskModel(
    //       title: 'test',
    //       body: 'test test',
    //       color: Colors.green,
    //       date: '04/12',
    //       time: '10:00 PM'),
    // ]),
  ];
}

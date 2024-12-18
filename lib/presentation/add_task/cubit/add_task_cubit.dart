import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:subul_g1_todo_app/core/globals.dart';
import 'package:subul_g1_todo_app/data/data_sources/hive_database.dart';
import 'package:subul_g1_todo_app/data/data_sources/local_variables_database.dart';
import 'package:subul_g1_todo_app/data/models/task_model.dart';
import 'package:subul_g1_todo_app/presentation/home/home_screen.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(DataChanged());

  changeState() {
    emit(DataChanged());
  }

  void addOrEditTask({required TaskModel newTask, TaskModel? editedTask}) {
    LocalVariablesDatabase().categoriesList[0].data.add(newTask);

    if (editedTask != null) {
      LocalVariablesDatabase().categoriesList[0].data.remove(editedTask);
    }

    Navigator.pushAndRemoveUntil(
        Globals.navigatorKey.currentContext!,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeScreen()),
        ModalRoute.withName('//'));
  }

  void addOrEditTaskByHive(
      {required TaskModel newTask, TaskModel? editedTask}) {
    if (editedTask != null) {
      // LocalVariablesDatabase().categoriesList[0].data.remove(editedTask);
      HiveDatabase().editTask(editedTask, newTask);
    } else {
      HiveDatabase().addTask(newTask);
    }

    Navigator.pushAndRemoveUntil(
        Globals.navigatorKey.currentContext!,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeScreen()),
        ModalRoute.withName('//'));
  }
}

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:subul_g1_todo_app/core/globals.dart';
import 'package:subul_g1_todo_app/core/my_application.dart';
import 'package:subul_g1_todo_app/data/data_sources/hive_database.dart';
import 'package:subul_g1_todo_app/data/data_sources/local_variables_database.dart';
import 'package:subul_g1_todo_app/data/models/task_model.dart';
import 'package:subul_g1_todo_app/presentation/login/login_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeDataChanged());

  void moveToDone(TaskModel taskModel) {
    // LocalVariablesDatabase().categoriesList[1].data.add(taskModel);
    // LocalVariablesDatabase().categoriesList[0].data.remove(taskModel);

    HiveDatabase().moveToDone(taskModel);

    emit(HomeDataChanged());
  }

  void deleteTask(TaskModel taskModel) {
    // LocalVariablesDatabase().categoriesList[2].data.add(taskModel);
    // LocalVariablesDatabase().categoriesList[0].data.remove(taskModel);

    HiveDatabase().deleteTask(taskModel);

    emit(HomeDataChanged());
  }

  void unDoTask(TaskModel taskModel) {
    // LocalVariablesDatabase().categoriesList[0].data.add(taskModel);
    // LocalVariablesDatabase().categoriesList[1].data.remove(taskModel);

    HiveDatabase().restoreTask(taskModel);

    emit(HomeDataChanged());
  }

  void unDeleteTask(TaskModel taskModel) {
    // LocalVariablesDatabase().categoriesList[0].data.add(taskModel);
    // LocalVariablesDatabase().categoriesList[2].data.remove(taskModel);

    HiveDatabase().unDeleteTask(taskModel);

    emit(HomeDataChanged());
  }

  void reRenderHome() {
    emit(HomeDataChanged());
  }

  logOut(BuildContext context) async {
    // uId = null;

    MyApplication.showLoadingDialog(Globals.navigatorKey.currentContext!);

    await FirebaseAuth.instance.signOut();

    Navigator.pop(Globals.navigatorKey.currentContext!);

    MyApplication.showToastView(message: "Logged out successfully");
    MyApplication.navigateToRemove(
        Globals.navigatorKey.currentContext!, LoginScreen());
  }
}

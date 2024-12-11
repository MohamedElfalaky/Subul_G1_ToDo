import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  int color;

  @HiveField(3)
  String date;

  @HiveField(4)
  String time;

  TaskModel({
    required this.title,
    required this.body,
    required this.color,
    required this.date,
    required this.time,
  });
}

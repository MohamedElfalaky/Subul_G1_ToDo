import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart'; // Make sure to generate this file using build_runner

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  Color color;

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

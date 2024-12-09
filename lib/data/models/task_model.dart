import 'package:flutter/material.dart';

// Model for individual ToDo item
class TaskModel {
  String title;
  String body;
  Color color;
  String date;
  String time;

  TaskModel({
    required this.title,
    required this.body,
    required this.color,
    required this.date,
    required this.time,
  });

  // Method to convert JSON to TaskModel
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      body: json['body'],
      color: Color(int.parse(json[
          'color'])), // Assuming color is stored as an int (e.g., 0xFF0000FF)
      date: json['date'],
      time: json['time'],
    );
  }

  // Method to convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'color':
          color.value.toString(), // Convert Color to integer and then to string
      'date': date,
      'time': time,
    };
  }
}

// Model for ToDo category
class TaskCategoryModel {
  final String category;
  final List<TaskModel> data;

  TaskCategoryModel({
    required this.category,
    required this.data,
  });

  // Method to convert JSON to TaskCategoryModel
  factory TaskCategoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<TaskModel> dataList = list.map((i) => TaskModel.fromJson(i)).toList();

    return TaskCategoryModel(
      category: json['category'],
      data: dataList,
    );
  }

  // Method to convert TaskCategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

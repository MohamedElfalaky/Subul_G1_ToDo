// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCategoryModelAdapter extends TypeAdapter<TaskCategoryModel> {
  @override
  final int typeId = 0;

  @override
  TaskCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCategoryModel(
      category: fields[0] as String,
      data: (fields[1] as List).cast<TaskModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskCategoryModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

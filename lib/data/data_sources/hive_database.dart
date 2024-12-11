import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:subul_g1_todo_app/data/models/task_category_model.dart';
import 'package:subul_g1_todo_app/data/models/task_model.dart';

class HiveDatabase {
  static final HiveDatabase _instance = HiveDatabase._private();

  HiveDatabase._private();

  factory HiveDatabase() {
    return _instance;
  }

  Box<TaskCategoryModel>? _taskCategoryBox;

// to configure hive in the beginning
  Future initHive() async {
    final docDir = await getApplicationDocumentsDirectory();
    Hive.init(docDir.path);

    Hive.registerAdapter(TaskCategoryModelAdapter());
    Hive.registerAdapter(TaskModelAdapter());

    _taskCategoryBox =
        await Hive.openBox<TaskCategoryModel>('taskCategoryModels');

    if (_taskCategoryBox!.isEmpty) {
      _taskCategoryBox!.addAll([
        TaskCategoryModel(category: 'ToDo', data: []),
        TaskCategoryModel(category: 'Done', data: []),
        TaskCategoryModel(category: 'Deleted', data: []),
      ]);
    }
  }

// Get all categories and their data from Hive

  List<TaskCategoryModel> getCategories() {
    return _taskCategoryBox!.values.toList();
  }

  // add new task
  Future<void> addTask(TaskModel task) async {
    TaskCategoryModel? todoCategory = _taskCategoryBox!.values.toList()[0];

    todoCategory.data.add(task);

    await _taskCategoryBox!.putAt(0, todoCategory);
  }

  Future<void> editTask(TaskModel editedTask, TaskModel newTask) async {
    TaskCategoryModel? todoCategory = _taskCategoryBox!.values.toList()[0];

    todoCategory.data.remove(editedTask);
    todoCategory.data.add(newTask);

    await _taskCategoryBox!.putAt(0, todoCategory);
  }

  Future<void> moveToDone(TaskModel task) async {
    TaskCategoryModel? todoCategory = _taskCategoryBox!.values.toList()[0];
    TaskCategoryModel? doneCategory = _taskCategoryBox!.values.toList()[1];

    todoCategory.data.remove(task);
    doneCategory.data.add(task);

    await _taskCategoryBox!.putAt(0, todoCategory);
    await _taskCategoryBox!.putAt(1, doneCategory);
  }

  Future<void> restoreTask(TaskModel task) async {
    TaskCategoryModel? todoCategory = _taskCategoryBox!.values.toList()[0];
    TaskCategoryModel? doneCategory = _taskCategoryBox!.values.toList()[1];

    todoCategory.data.add(task);
    doneCategory.data.remove(task);

    await _taskCategoryBox!.putAt(0, todoCategory);
    await _taskCategoryBox!.putAt(1, doneCategory);
  }

  Future<void> deleteTask(TaskModel task) async {
    TaskCategoryModel? todoCategory = _taskCategoryBox!.values.toList()[0];
    TaskCategoryModel? deletedCategory = _taskCategoryBox!.values.toList()[2];

    todoCategory.data.remove(task);
    deletedCategory.data.add(task);

    await _taskCategoryBox!.putAt(0, todoCategory);
    await _taskCategoryBox!.putAt(2, deletedCategory);
  }

  Future<void> unDeleteTask(TaskModel task) async {
    TaskCategoryModel? todoCategory = _taskCategoryBox!.values.toList()[0];
    TaskCategoryModel? deletedCategory = _taskCategoryBox!.values.toList()[2];

    todoCategory.data.add(task);
    deletedCategory.data.remove(task);

    await _taskCategoryBox!.putAt(0, todoCategory);
    await _taskCategoryBox!.putAt(2, deletedCategory);
  }
}

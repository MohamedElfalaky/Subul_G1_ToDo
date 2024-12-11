import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:subul_g1_todo_app/data/data_sources/hive_database.dart';
import 'package:subul_g1_todo_app/data/models/task_category_model.dart';
import 'package:subul_g1_todo_app/data/models/task_model.dart';
import 'package:subul_g1_todo_app/presentation/home/cubit/home_cubit.dart';
import 'package:subul_g1_todo_app/resources/colors_palette.dart';
import 'package:collection/collection.dart';
import 'package:subul_g1_todo_app/resources/icons.dart';
import 'package:subul_g1_todo_app/resources/text_styles.dart';
import 'package:subul_g1_todo_app/presentation/add_task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 40,
                ),

                // category filter
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: HiveDatabase().getCategories().mapIndexed(
                    (index, element) {
                      return categoryCard(
                          index: index, category: element, context: context);
                    },
                  ).toList(),
                ),

                // place holder

                Expanded(
                    child: ListView.builder(
                        itemCount: HiveDatabase()
                                .getCategories()[_selectedCategoryIndex]
                                .data
                                .isEmpty
                            ? 1
                            : HiveDatabase()
                                .getCategories()[_selectedCategoryIndex]
                                .data
                                .length,
                        itemBuilder: (context, index) {
                          List<TaskModel> myDate = HiveDatabase()
                              .getCategories()[_selectedCategoryIndex]
                              .data;

                          return myDate.isEmpty
                              ? Center(
                                  child: SvgPicture.asset(noNotedPlacholder),
                                )
                              : _taskCard(
                                  taskModel: myDate[index],
                                  context: context,
                                  currentTaskIndex: index);
                        }))
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddTaskScreen(),
              ),
            );
          },
          child: const Icon(Icons.add, size: 28),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '',
            ),
          ],
        ));
  }

  Widget _taskCard(
      {required TaskModel taskModel,
      required context,
      required int currentTaskIndex}) {
    return Slidable(
      key: const ValueKey(0),
      closeOnScroll: true,
      startActionPane: _selectedCategoryIndex != 0
          ? null
          : ActionPane(motion: ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          AddTaskScreen(editedTask: taskModel),
                    ),
                  );
                },
                backgroundColor: Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ]),
      endActionPane: ActionPane(motion: ScrollMotion(), children: [
        if (_selectedCategoryIndex == 0) ...[
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (context) {
              context.read<HomeCubit>().moveToDone(taskModel);
            },
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.done,
            label: 'Done',
          ),
          SlidableAction(
            onPressed: (context) {
              context.read<HomeCubit>().deleteTask(taskModel);
            },
            backgroundColor: Color.fromARGB(255, 207, 3, 3),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
        if (_selectedCategoryIndex == 1)
          SlidableAction(
            onPressed: (context) {
              context.read<HomeCubit>().unDoTask(taskModel);
            },
            backgroundColor: Color.fromARGB(255, 181, 6, 220),
            foregroundColor: Colors.white,
            icon: Icons.undo,
            label: 'Undo',
          ),
        if (_selectedCategoryIndex == 2)
          SlidableAction(
            onPressed: (context) {
              context.read<HomeCubit>().unDeleteTask(taskModel);
            },
            backgroundColor: Color.fromARGB(255, 6, 174, 220),
            foregroundColor: Colors.white,
            icon: Icons.undo,
            label: 'restore',
          )
      ]),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(taskModel.color).withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    taskModel.title,
                    style: AppTextStyles.titleLarge.copyWith(fontSize: 28),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      taskModel.date,
                      style: AppTextStyles.bodySmall.copyWith(
                          color: ColorsPalette.blackColor.withOpacity(0.6)),
                    ),
                    Text(
                      taskModel.time,
                      style: AppTextStyles.bodySmall.copyWith(
                          color: ColorsPalette.blackColor.withOpacity(0.6)),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              taskModel.body,
              style: AppTextStyles.bodyMedium,
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  Widget categoryCard(
      {required int index,
      required TaskCategoryModel category,
      required BuildContext context}) {
    return InkWell(
      onTap: () {
        _selectedCategoryIndex = index;

        context.read<HomeCubit>().reRenderHome();
      },
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: _selectedCategoryIndex == index
                ? ColorsPalette.primaryColor
                : null,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 2, color: ColorsPalette.blackColor.withOpacity(0.30))),
        child: Text(
          category.category,
          style: TextStyle(
              color: _selectedCategoryIndex == index
                  ? ColorsPalette.blackColor
                  : ColorsPalette.blackColor.withOpacity(0.30)),
        ),
      ),
    );
  }
}

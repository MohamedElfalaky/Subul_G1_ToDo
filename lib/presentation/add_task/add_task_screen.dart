import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:subul_g1_todo_app/core/globals.dart';
import 'package:subul_g1_todo_app/data/data_sources/hive_database.dart';
import 'package:subul_g1_todo_app/data/data_sources/local_variables_database.dart';
import 'package:subul_g1_todo_app/data/models/task_model.dart';
import 'package:subul_g1_todo_app/presentation/add_task/cubit/add_task_cubit.dart';
import 'package:subul_g1_todo_app/resources/colors_palette.dart';
import 'package:subul_g1_todo_app/resources/icons.dart';
import 'package:subul_g1_todo_app/resources/text_styles.dart';
import 'package:subul_g1_todo_app/presentation/home/home_screen.dart';

class AddTaskScreen extends StatelessWidget {
  TaskModel? editedTask;

  AddTaskScreen({super.key, this.editedTask});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubit(),
      child: AddTaskPage(
        editedTask: editedTask,
      ),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  TaskModel? editedTask;
  AddTaskPage({super.key, this.editedTask});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  List<int> cardsColors = [
    0xFF00FF00, // Green
    0xFFFF0000, // Red
    0xFF0000FF, // Blue
    0xFF000000, // Black
    0xFFFFFF00, // Yellow
    0xFFFFFFFF, // White
    0xFFFFA500, // Orange
    0xFFFFC0CB, // Pink
    0xFFFFE082, // AmberAccent
    0xFF800080, // Purple
    0xFFFFC107, // Amber
    0xFF448AFF, // BlueAccent
    0xFFFF7043, // DeepOrangeAccent
  ];

  int? _selectedColor;

  bool? selectedColorError;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDiscriptionController =
      TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController taskTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.editedTask != null) {
      // edit task case
      taskNameController.text = widget.editedTask!.title;
      taskDiscriptionController.text = widget.editedTask!.body;
      taskDateController.text = widget.editedTask!.date;
      taskTimeController.text = widget.editedTask!.time;
      _selectedColor = widget.editedTask!.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorsPalette.scafoldColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Image.asset(closeIcon)),
                ),
                Image.asset(starIcon),
                Text('New Task'),
                SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: taskNameController,
                  decoration: InputDecoration(hintText: 'Name your new task'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Task name cant be empty';
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                    controller: taskDiscriptionController,
                    decoration: InputDecoration(hintText: 'Describe it'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Task description cant be empty';
                      }
                    }),
                SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Card color',
                    style: AppTextStyles.bodyMedium
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocBuilder<AddTaskCubit, AddTaskState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              for (int i = 0; i < cardsColors.length; i++)
                                InkWell(
                                  onTap: () {
                                    _selectedColor = cardsColors[i];

                                    context.read<AddTaskCubit>().changeState();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(4),
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color:
                                                _selectedColor == cardsColors[i]
                                                    ? ColorsPalette.whiteColor
                                                    : Colors.transparent,
                                            width: 4),
                                        color: Color(cardsColors[i])),
                                  ),
                                )
                            ],
                          ),
                          if (selectedColorError == true)
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'Color cant be empty',
                                style: AppTextStyles.bodySmall
                                    .copyWith(color: Colors.red),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          DateTime? selectedDate;
                          selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 7)));

                          if (selectedDate != null) {
                            taskDateController.text =
                                DateFormat('dd/MM').format(selectedDate);
                          }
                        },
                        child: TextFormField(
                            controller: taskDateController,
                            enabled: false,
                            decoration:
                                InputDecoration(hintText: 'Select Date'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Date cant be empty';
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          TimeOfDay? selectedTime;
                          selectedTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          if (selectedTime != null) {
                            taskTimeController.text =
                                selectedTime.format(context);
                          }
                        },
                        child: TextFormField(
                            controller: taskTimeController,
                            enabled: false,
                            decoration:
                                InputDecoration(hintText: 'Select Time'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Time cant be empty';
                              }
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 250,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_selectedColor == null) {
                          selectedColorError = true;

                          context.read<AddTaskCubit>().changeState();
                        } else {
                          selectedColorError = false;

                          TaskModel newTask = TaskModel(
                              title: taskNameController.text,
                              body: taskDiscriptionController.text,
                              color: _selectedColor!,
                              date: taskDateController.text,
                              time: taskTimeController.text);

                          context.read<AddTaskCubit>().addOrEditTaskByHive(
                              newTask: newTask, editedTask: widget.editedTask);
                        }
                      }
                    },
                    child: Text(widget.editedTask != null
                        ? 'Edit the task'
                        : 'Add the task'))
              ],
            ),
          ),
        )),
      ),
    );
  }
}

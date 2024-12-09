import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:subul_g1_todo_app/data/data_sources/local_variables_database.dart';
import 'package:subul_g1_todo_app/data/models/task_model.dart';
import 'package:subul_g1_todo_app/resources/colors_palette.dart';
import 'package:subul_g1_todo_app/resources/icons.dart';
import 'package:subul_g1_todo_app/resources/text_styles.dart';
import 'package:subul_g1_todo_app/screens/home_screen.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? editedTask;
  const AddTaskScreen({super.key, this.editedTask});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  List cardsColors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.yellow,
    Colors.white,
    Colors.orange,
    Colors.pink,
    Colors.amberAccent,
    Colors.purple,
    Colors.amber,
    Colors.blueAccent,
    Colors.deepOrangeAccent
  ];

  Color? _selectedColor;

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
                  child: Row(
                    children: [
                      for (int i = 0; i < cardsColors.length; i++)
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedColor = cardsColors[i];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(4),
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: _selectedColor == cardsColors[i]
                                        ? ColorsPalette.whiteColor
                                        : Colors.transparent,
                                    width: 4),
                                color: cardsColors[i]),
                          ),
                        )
                    ],
                  ),
                ),
                if (selectedColorError == true)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Color cant be empty',
                      style:
                          AppTextStyles.bodySmall.copyWith(color: Colors.red),
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
                          setState(() {
                            selectedColorError = true;
                          });
                        } else {
                          selectedColorError = false;

                          if (widget.editedTask == null) {
                            LocalVariablesDatabase().categoriesList[0].data.add(
                                TaskModel(
                                    title: taskNameController.text,
                                    body: taskDiscriptionController.text,
                                    color: _selectedColor!,
                                    date: taskDateController.text,
                                    time: taskTimeController.text));
                          } else {
                            LocalVariablesDatabase()
                                .categoriesList[0]
                                .data
                                .remove(widget.editedTask);

                            LocalVariablesDatabase().categoriesList[0].data.add(
                                TaskModel(
                                    title: taskNameController.text,
                                    body: taskDiscriptionController.text,
                                    color: _selectedColor!,
                                    date: taskDateController.text,
                                    time: taskTimeController.text));
                          }

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const HomeScreen()),
                              ModalRoute.withName('//'));
                        }
                      }
                    },
                    child: Text(widget.editedTask != null
                        ? 'Add the task'
                        : 'Edit the task'))
              ],
            ),
          ),
        )),
      ),
    );
  }
}

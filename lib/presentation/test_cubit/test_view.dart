import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_g1_todo_app/presentation/test_cubit/cubit/test_cubit.dart';
import 'package:subul_g1_todo_app/presentation/test_cubit/trainer_model.dart';

class TestCubitScreen extends StatelessWidget {
  const TestCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestCubit(),
      child: TestCubitView(),
    );
  }
}

class TestCubitView extends StatelessWidget {
  const TestCubitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<TestCubit, TestState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(child: Text('Test')),
                for (int i = 0;
                    i < context.read<TestCubit>().trainersList.length;
                    i++)
                  _trainerCard(
                      context.read<TestCubit>().trainersList[i], context)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _trainerCard(TrainerModel trainerModel, BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: trainerModel.userInput);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
              value: trainerModel.isSelected,
              onChanged: (val) {
                context.read<TestCubit>().selectTrainer(trainerModel, val!);
              }),
          Text(trainerModel.name),
          SizedBox(
            width: 70,
          ),
          Expanded(
              child: TextField(
            controller: textEditingController,
            enabled: trainerModel.isSelected,
            onChanged: (value) {
              context.read<TestCubit>().changeTrainerText(trainerModel, value);
            },
          ))
        ],
      ),
    );
  }
}

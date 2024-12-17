import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:subul_g1_todo_app/presentation/test_cubit/trainer_model.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  List<TrainerModel> trainersList = [
    TrainerModel(name: 'Trainer 1'),
    TrainerModel(name: 'Trainer 2', userInput: 'hello'),
    TrainerModel(name: 'Trainer 3', isSelected: true),
    TrainerModel(name: 'Trainer 4'),
  ];

  selectTrainer(TrainerModel trainerModel, bool newVal) {
    trainerModel.isSelected = newVal;
    emit(TrainerSelectionChanged());
  }

  changeTrainerText(TrainerModel trainerModel, String newVal) {
    trainerModel.userInput = newVal;
  }
}

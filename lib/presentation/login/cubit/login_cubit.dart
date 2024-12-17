import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:subul_g1_todo_app/core/globals.dart';
import 'package:subul_g1_todo_app/core/my_application.dart';
import 'package:subul_g1_todo_app/presentation/home/home_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> loginMethod() async {
    // show loading dialog

    MyApplication.showLoadingDialog(Globals.navigatorKey.currentState!.context);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: mailController.text, password: passwordController.text);

      Navigator.pop(Globals.navigatorKey.currentState!.context);

      MyApplication.showToastView(message: "Logged in successfully");

      MyApplication.navigateToRemove(
          Globals.navigatorKey.currentState!.context, HomeScreen());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(Globals.navigatorKey.currentState!.context);
      MyApplication.showToastView(message: e.code);
    }
  }
}

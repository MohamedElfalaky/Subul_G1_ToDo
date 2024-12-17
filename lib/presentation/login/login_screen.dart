import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_g1_todo_app/core/my_application.dart';
import 'package:subul_g1_todo_app/presentation/login/cubit/login_cubit.dart';
import 'package:subul_g1_todo_app/presentation/registration/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 28, color: Colors.pink),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("email")),
                  controller: context.read<LoginCubit>().mailController,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("Upassword")),
                  controller: context.read<LoginCubit>().passwordController,
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await context.read<LoginCubit>().loginMethod();
                      }
                    },
                    child: const Text("Login")),
                Row(
                  children: [
                    const Text("dont have an account ?"),
                    TextButton(
                        onPressed: () {
                          MyApplication.navigateToRemove(
                              context, const RegistrationScreen());
                        },
                        child: const Text("register"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

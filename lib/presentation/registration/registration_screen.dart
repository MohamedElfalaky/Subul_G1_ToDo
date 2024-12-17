import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_g1_todo_app/core/my_application.dart';
import 'package:subul_g1_todo_app/main.dart';
import 'package:subul_g1_todo_app/presentation/home/cubit/home_cubit.dart';
import 'package:subul_g1_todo_app/presentation/login/login_screen.dart';
import 'package:subul_g1_todo_app/presentation/registration/cubit/registration_cubit.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

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
                  "Registration",
                  style: TextStyle(fontSize: 28, color: Colors.pink),
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocBuilder<RegistrationCubit, RegistrationState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () async {
                        await context
                            .read<RegistrationCubit>()
                            .pickProfileImage();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: context.read<RegistrationCubit>().profileImage ==
                                null
                            ? Center(
                                child: Text(
                                  'Upload picture',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Image.file(context
                                .read<RegistrationCubit>()
                                .profileImage!),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 22,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("User name")),
                  controller:
                      context.read<RegistrationCubit>().userNameController,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("email")),
                  controller: context.read<RegistrationCubit>().mailController,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("Password")),
                  controller:
                      context.read<RegistrationCubit>().passwordController,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(label: Text("confirm password")),
                  validator: (value) {
                    if (value !=
                        context
                            .read<RegistrationCubit>()
                            .passwordController
                            .text) {
                      return "passwords do not match";
                    }
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await context
                            .read<RegistrationCubit>()
                            .registerMethod();
                      }
                    },
                    child: const Text("Register")),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text("have an account ?"),
                    TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute<void>(
                          //     builder: (BuildContext context) =>
                          //         const LoginScreen(),
                          //   ),
                          // );

                          MyApplication.navigateToRemove(
                              context, LoginScreen());
                        },
                        child: const Text("Login"))
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

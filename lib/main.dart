import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:subul_g1_todo_app/core/globals.dart';
import 'package:subul_g1_todo_app/data/data_sources/hive_database.dart';
import 'package:subul_g1_todo_app/firebase_options.dart';
import 'package:subul_g1_todo_app/presentation/home/home_screen.dart';
import 'package:subul_g1_todo_app/presentation/registration/registration_screen.dart';
import 'package:subul_g1_todo_app/resources/colors_palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveDatabase().initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Globals.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Subul TO DO App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ColorsPalette.whiteColor,
            contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(18))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                minimumSize: Size(215, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ))),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

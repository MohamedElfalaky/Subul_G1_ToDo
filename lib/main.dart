import 'package:flutter/material.dart';
import 'package:subul_g1_todo_app/data/data_sources/local_storage_database.dart';
import 'package:subul_g1_todo_app/resources/colors_palette.dart';
import 'package:subul_g1_todo_app/screens/home_screen.dart';

void main() async {
  await HiveDatabase().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

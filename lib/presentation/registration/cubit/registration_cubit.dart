// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:subul_g1_todo_app/core/globals.dart';
import 'package:subul_g1_todo_app/core/my_application.dart';
import 'package:subul_g1_todo_app/core/services/firebase_auth.dart';
import 'package:subul_g1_todo_app/main.dart';
import 'package:subul_g1_todo_app/presentation/home/home_screen.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  final userNameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  File? profileImage;

  // Method to pick image
  Future<void> pickProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(RegistrationImagePicked());
    }
  }

  Future<void> registerMethod() async {
    // show loading dialog

    MyApplication.showLoadingDialog(Globals.navigatorKey.currentState!.context);

    try {
      UserCredential userCredential = await FirebaseAuthService()
          .getUserCredintial(
              mail: mailController.text, password: passwordController.text);

      // await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: mailController.text, password: passwordController.text);

      // Upload Profile Image if available
      String? imageUrl;
      if (profileImage != null) {
        imageUrl =
            await uploadProfileImage(userCredential.user!.uid, profileImage!);
      }

      await createUserDoc(userCredential, imageUrl);

      Navigator.pop(Globals.navigatorKey.currentState!.context);

      MyApplication.showToastView(
          message: "You have been registered successfully");

      // await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      MyApplication.navigateToRemove(
          Globals.navigatorKey.currentState!.context, const HomeScreen());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(Globals.navigatorKey.currentState!.context);

      MyApplication.showToastView(message: e.code);
    } catch (e) {
      Navigator.pop(Globals.navigatorKey.currentState!.context);

      MyApplication.showToastView(message: e.toString());
    }
  }

  // Upload Image to Firebase Storage
  Future<String> uploadProfileImage(String uid, File image) async {
    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');
      await storageRef.putFile(image);
      return await storageRef.getDownloadURL();
    } catch (e) {
      MyApplication.showToastView(message: "Image upload failed: $e");
      throw Exception("Image upload failed");
    }
  }

  // Create User Document in Firestore
  Future<void> createUserDoc(
      UserCredential? userCredential, String? imageUrl) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
        'profileImageUrl': imageUrl, // Save image URL
      });
    }
  }
}

import 'package:dog_tracker/controllers/auth_controller.dart';
import 'package:dog_tracker/controllers/user_controller.dart';
import 'package:dog_tracker/screens/auth/sign_up_screen.dart';
import 'package:dog_tracker/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        await Firebase.initializeApp();
        return Get.put<UserController>(UserController());
      },
      builder: (_) {
        return Get.find<AuthController>().user?.uid != null
            ? HomeScreen()
            : SignUpScreen();
      },
    );
  }
}

import 'package:dog_tracker/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SafeArea(
          child: FlatButton(
            onPressed: () => Get.find<AuthController>().signOut(),
            child: Text("Sign Out"),
          ),
        )
      ],
    ));
  }
}

import 'package:dog_tracker/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileMenuScreen extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CommonBottomNavBar(),
      body: Center(
        child: Text("Menu Screen"),
      ),
    );
  }
}

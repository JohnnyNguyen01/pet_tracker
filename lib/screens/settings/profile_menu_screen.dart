import 'package:dog_tracker/controllers/profile_menu_screen_controller.dart';
import 'package:dog_tracker/util/constants.dart';
import 'package:dog_tracker/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileMenuScreen extends GetWidget {
  //todo: check why binding doesn't work with GetWidget<ProfileMenuScreenController>
  final _controller = Get.put(ProfileMenuScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CommonBottomNavBar(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Settings",
                  style: Constants.h2,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: _controller.handleLogOutBtn,
                  child: Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

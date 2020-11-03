import 'package:dog_tracker/controllers/profile_menu_screen_controller.dart';
import 'package:dog_tracker/util/constants.dart';
import 'package:dog_tracker/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileMenuScreen extends StatelessWidget {
  //todo: check why binding doesn't work with GetWidget<ProfileMenuScreenController>
  final _controller = Get.put(ProfileMenuScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CommonBottomNavBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.indigoAccent,
              child: Center(),
            ),
            Heading(title: "Account Settings"),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text("Change Email"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lock_outlined),
              title: Text("Change Password"),
              onTap: () => _controller.handleChangePasswordBtn(context),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: _controller.handleLogOutBtn,
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Heading extends StatelessWidget {
  final String title;
  Heading({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          title,
          style: Constants.dialogTitle.copyWith(color: Colors.grey.shade600),
        ),
      ),
    );
  }
}

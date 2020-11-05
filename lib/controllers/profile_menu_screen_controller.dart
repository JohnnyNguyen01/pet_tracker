import 'package:dog_tracker/screens/auth/sign_up_screen.dart';
import 'package:dog_tracker/services/api/auth.dart';
import 'package:dog_tracker/widgets/change_password_dialog/alert_dialog.dart';
import 'package:get/get.dart';
import 'dart:async';
//todo: get rid of this package and the ui Code of dialog box
import 'package:flutter/material.dart';

class ProfileMenuScreenController extends GetxController {
  Future<void> handleLogOutBtn() async {
    await Auth.instance.logOutCurrentUser();
    Get.offAll(SignUpScreen());
  }

  Future<void> handleChangePasswordBtn(BuildContext context) async {
    //1. Open dialog box
    //2. get the user to enter new password
    //3. Check password is acceptable
    //4. Accept or decline new password
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return ChangePasswordDialog();
        });
  }

  @override
  FutureOr onClose() {
    return super.onClose();
  }
}

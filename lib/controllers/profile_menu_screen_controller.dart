import 'package:dog_tracker/screens/auth/sign_up_screen.dart';
import 'package:dog_tracker/services/api/auth.dart';
import 'package:get/get.dart';
import 'dart:async';

class ProfileMenuScreenController extends GetxController {
  Future<void> handleLogOutBtn() async {
    await Auth.instance.logOutCurrentUser();
    Get.offAll(SignUpScreen());
  }

  @override
  FutureOr onClose() {
    // TODO: implement onClose
    return super.onClose();
  }
}

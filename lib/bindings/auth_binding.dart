/*
  This binding is initialized at the start of the app, apparently as 
  an alternative to provider.
  todo: figure out how this works in depth
 */

import 'package:dog_tracker/controllers/auth_controller.dart';
import 'package:dog_tracker/controllers/home_screen_dialog_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DialogBoxController());
  }
}

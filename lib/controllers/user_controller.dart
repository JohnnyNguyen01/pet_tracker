import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  //getter for the uModel
  UserModel get user => _userModel.value;
  //setter fot the userModel
  set user(UserModel value) => this._userModel.value = value;
  //reset _userModel to default value
  void clear() => this._userModel.value = UserModel();
}

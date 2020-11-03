import 'package:dog_tracker/services/api/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class ChangePasswordDialogController extends GetxController {
  RxString _currentPassword = "".obs;
  RxString _currentPassFromFirebase = "".obs;
  RxString _newPassword = "".obs;
  RxString _confirmNewPassword = "".obs;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RxString get currentPassword => _currentPassword;

  RxString get newPassword => _newPassword;
  RxString get confirmNewPassword => _confirmNewPassword;
  GlobalKey get formKey => _formKey;

  @override
  void onInit() {
    super.onInit();
  }

  void setCurrentPasswordTF(String password) {
    _currentPassword.value = password;
    _currentPassword.refresh();
    print("setCurrentPasswordTF called");
  }

  void setNewPasswordTF(String newPassword) {
    _newPassword.value = newPassword;
    _newPassword.refresh();
  }

  void setConfirmPasswordTF(String confirmPassword) {
    _confirmNewPassword.value = confirmPassword;
    _confirmNewPassword.refresh();
  }

  void handleConfirmBtn() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    // Auth.instance.updateCurrentUserPassword(_confirmNewPassword.value);
  }

  void handleCancelButton(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  FutureOr onClose() {
    _currentPassword.close();
    _confirmNewPassword.close();
    _newPassword.close();
    return super.onClose();
  }
}

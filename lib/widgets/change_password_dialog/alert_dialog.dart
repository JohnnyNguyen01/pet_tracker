import 'package:dog_tracker/util/constants.dart';
import 'package:dog_tracker/widgets/change_password_dialog/change_password_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordDialog extends GetWidget<ChangePasswordDialogController> {
  final _controller = Get.put(ChangePasswordDialogController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change Password"),
      content: SingleChildScrollView(
        child: Form(
          key: _controller.formKey,
          child: ListBody(
            children: [
              _buildCurrentPass(),
              _buildNewPass(),
              _buildConfirmPass(),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                      child: Text(
                        "Confirm",
                        style: Constants.poppinsWhiteText,
                      ),
                      color: Colors.indigo,
                      onPressed: () => _controller.handleConfirmBtn()),
                  SizedBox(width: 5),
                  FlatButton(
                    onPressed: () => _controller.handleCancelButton(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPass() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "Enter Current Password",
      ),
      validator: (String value) {
        if (value.isEmpty || value == null) {
          return "Please type in your current password";
        }
        return null;
      },
      onChanged: (value) => _controller.setCurrentPasswordTF(value),
    );
  }

  Widget _buildNewPass() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(labelText: "Enter New Password"),
      validator: (String value) {
        if (value.isNullOrBlank) {
          return "Please type in a new password";
        } else if (value.length < 6) {
          return "Password must be 6 characters long";
        }
        return null;
      },
      onChanged: (value) => _controller.setNewPasswordTF(value),
    );
  }

  Widget _buildConfirmPass() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Confirm New Password"),
      validator: (String value) {
        if (value.isNullOrBlank) {
          return "Please type in the same new password";
        } else if (value.length < 6) {
          return "Password must be 6 characters long";
        } else if (value != controller.newPassword.value) {
          return "Passwords don't match";
        }
        return null;
      },
      onChanged: (value) => _controller.setConfirmPasswordTF(value),
    );
  }
}

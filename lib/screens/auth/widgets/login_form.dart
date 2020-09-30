import 'package:dog_tracker/controllers/auth_controller.dart';
import 'package:dog_tracker/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends GetWidget<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.0),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Johnny",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Johnny",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "3 characters minimum",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(height: 15.0),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width / 1.25,
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  controller.handleSignUpButton(_nameController.text,
                      _passwordController.text, _emailController.text);
                }, //=>controller.login(_email, _password),
                color: Color(0xFFB6C6FF),
                hoverColor: Colors.white24,
                child: Text(
                  "Sign up",
                  style: Constants.poppinsWhiteText,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

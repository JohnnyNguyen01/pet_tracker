import 'package:dog_tracker/controllers/login_screen_controller.dart';
import 'package:dog_tracker/screens/auth/sign_up_screen.dart';
import 'package:dog_tracker/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<LoginScreenController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreenController controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("lib/assets/images/undraw_welcome_cats_thqn.png"),
        Container(
          width: MediaQuery.of(context).size.width / 1.25,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      controller.login(
                          _emailController.text, _passwordController.text);
                    }, //=>controller.login(_email, _password),
                    color: Color(0xFFB6C6FF),
                    hoverColor: Colors.white24,
                    child: Text(
                      "Login",
                      style: Constants.poppinsWhiteText,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      Get.off(SignUpScreen());
                    },
                    child: Text(
                      "Sign Up",
                      style: Constants.loginButton,
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

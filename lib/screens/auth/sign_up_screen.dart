import 'package:dog_tracker/screens/auth/widgets/login_form.dart';
import 'package:dog_tracker/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset("lib/assets/images/undraw_welcome_cats_thqn.png"),
            Lottie.asset(
              'lib/assets/animations/pet_lover.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            Text(
              "Pet Finder",
              style: Constants.h2,
            ),
            LoginForm(),
            FlatButton(
              onPressed: () => Get.to(LoginScreen()),
              child: Text(
                "Login",
                style: Constants.loginButton,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

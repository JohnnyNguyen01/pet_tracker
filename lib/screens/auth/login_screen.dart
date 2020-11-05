import 'package:dog_tracker/controllers/login_screen_controller.dart';
import 'package:dog_tracker/screens/auth/sign_up_screen.dart';
import 'package:dog_tracker/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends GetWidget<LoginScreenController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "example@exampleemail.com",
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
                      controller.isLoggingIn.value == false
                          ? Column(
                              children: [
                                ButtonTheme(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 1.25,
                                  height: 45.0,
                                  child: RaisedButton(
                                    onPressed: () {
                                      controller.login(_emailController.text,
                                          _passwordController.text);
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
                                  ),
                                )
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

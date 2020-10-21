import 'package:dog_tracker/bindings/auth_binding.dart';
import 'package:dog_tracker/bindings/homescreen_binding.dart';
import 'package:dog_tracker/bindings/loginscreen_controller.dart';
import 'package:dog_tracker/screens/auth/login_screen.dart';
import 'package:dog_tracker/screens/home/home_screen.dart';
import 'package:dog_tracker/services/api/device.dart';
import 'package:dog_tracker/services/database.dart';
import 'package:dog_tracker/util/root.dart';
import 'package:dog_tracker/util/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      title: 'Flutter Demo',
      theme: Themes.primaryTheme,
      home: Root(),
      onInit: () async {
        if (await DeviceHelpers.thisDeviceIsDBGps()) {
          DeviceHelpers.uploadLocationEveryTenSeconds();
        }
      },
      getPages: [
        GetPage(
          name: "/homescreen",
          page: () => HomeScreen(),
          binding: HomeScreenBinding(),
        ),
        GetPage(
          name: "/loginscreen",
          page: () => LoginScreen(),
          binding: LoginScreenBinding(),
        ),
      ],
    );
  }
}

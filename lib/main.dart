import 'package:dog_tracker/bindings/auth_binding.dart';
import 'package:dog_tracker/util/root.dart';
import 'package:dog_tracker/util/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GetMaterialApp(
            initialBinding: AuthBinding(),
            title: 'Flutter Demo',
            theme: Themes.primaryTheme,
            home: Root(),
          );
        });
  }
}

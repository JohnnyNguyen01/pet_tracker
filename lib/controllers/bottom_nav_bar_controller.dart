import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  RxInt bottomNavIndex = 0.obs;

  void changeBottomNav(int index) {
    bottomNavIndex.value = index;
    bottomNavIndex.refresh();
    print(bottomNavIndex.value);
  }
}

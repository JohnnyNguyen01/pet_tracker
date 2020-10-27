import 'package:dog_tracker/screens/settings/profile_menu_screen.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  RxInt bottomNavIndex = 0.obs;

  void changeBottomNav(int index) {
    bottomNavIndex.value = index;
    bottomNavIndex.refresh();
    print(bottomNavIndex.value);
    switch (bottomNavIndex.value) {
      case 0:
        {
          Get.toNamed('/homescreen');
        }
        break;
      case 2:
        {
          Get.to(ProfileMenuScreen());
        }
        break;
      default:
    }
  }
}

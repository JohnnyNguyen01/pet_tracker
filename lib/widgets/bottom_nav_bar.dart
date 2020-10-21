import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dog_tracker/controllers/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonBottomNavBar extends StatelessWidget {
  final _pageController = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BubbleBottomBar(
        opacity: .2,
        currentIndex: _pageController.bottomNavIndex.value,
        onTap: _pageController.changeBottomNav,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.dashboard,
                color: Colors.indigo,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.indigo,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.folder_open,
                color: Colors.indigo,
              ),
              activeIcon: Icon(
                Icons.folder_open,
                color: Colors.indigo,
              ),
              title: Text("Folders")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.menu,
                color: Colors.indigo,
              ),
              activeIcon: Icon(
                Icons.menu,
                color: Colors.indigo,
              ),
              title: Text("Menu"))
        ],
      ),
    );
  }
}

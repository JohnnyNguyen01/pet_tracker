import 'package:dog_tracker/controllers/home_screen_controller.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    //Controller binding
    //Get.lazyPut(() => HomeScreenController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Obx(
        () => BubbleBottomBar(
          opacity: .2,
          currentIndex: controller.bottomNavIndex.value,
          onTap: controller.changeBottomNav,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          fabLocation: BubbleBottomBarFabLocation.end, //new
          hasNotch: true, //new
          hasInk: true, //new, gives a cute ink effect
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: Colors.red,
                ),
                title: Text("Home")),
            // BubbleBottomBarItem(
            //     backgroundColor: Colors.deepPurple,
            //     icon: Icon(
            //       Icons.access_time,
            //       color: Colors.black,
            //     ),
            //     activeIcon: Icon(
            //       Icons.access_time,
            //       color: Colors.deepPurple,
            //     ),
            //     title: Text("Logs")),
            BubbleBottomBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(
                  Icons.folder_open,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.folder_open,
                  color: Colors.indigo,
                ),
                title: Text("Folders")),
            BubbleBottomBarItem(
                backgroundColor: Colors.green,
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.menu,
                  color: Colors.green,
                ),
                title: Text("Menu"))
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<LatLng>(
                future: controller.getCurrentLatLng(),
                builder: (context, snapshot) {
                  print("Current Longitude and Latitude are: ${snapshot.data}");
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: snapshot.data,
                      zoom: 20,
                    ),
                    onMapCreated: (GoogleMapController controller) {},
                  );
                }),

            // FlatButton(
            //   onPressed: () => Get.find<AuthController>().signOut(),
            //   child: Text("Sign Out"),
            // ),
          ],
        ),
      ),
    );
  }
}

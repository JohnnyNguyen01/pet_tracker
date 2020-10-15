import 'package:dog_tracker/controllers/home_screen_controller.dart';
import 'package:dog_tracker/widgets/bottom_nav_bar.dart';
import 'package:dog_tracker/widgets/nav_bar_fab.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    //Controller binding
    //Get.lazyPut(() => HomeScreenController());
    return Scaffold(
      floatingActionButton: NavBarFABButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: CommonBottomNavBar(),
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

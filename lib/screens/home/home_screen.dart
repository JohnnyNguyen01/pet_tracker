import 'package:dog_tracker/controllers/home_screen_controller.dart';
import 'package:dog_tracker/widgets/bottom_nav_bar.dart';
import 'package:dog_tracker/widgets/nav_bar_fab.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
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
                  if (snapshot.connectionState == ConnectionState.active) {
                    print(snapshot.data);
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return Obx(
                      () => GoogleMap(
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        markers: controller.markers.value,
                        initialCameraPosition: CameraPosition(
                          target: snapshot.data,
                          zoom: 20,
                        ),
                        onMapCreated: (GoogleMapController controller) {},
                      ),
                    );
                }),
            FlatButton(
              onPressed: () async =>
                  print(await controller.getCurrentLocation()),
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dog_tracker/controllers/home_screen_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(-33.865143, 151.209900),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {},
        ),
        Positioned(
          bottom: 15.0,
          right: 15.0,
          child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                controller.getLocation().then((value) => print(value));
              }),
        ),
        // FlatButton(
        //   onPressed: () => Get.find<AuthController>().signOut(),
        //   child: Text("Sign Out"),
        // ),
      ],
    ));
  }
}

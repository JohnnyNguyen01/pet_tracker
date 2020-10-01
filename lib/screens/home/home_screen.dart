import 'package:dog_tracker/controllers/home_screen_controller.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
        colorStartAnimation: Theme.of(context).primaryColor,
        colorEndAnimation: Theme.of(context).accentColor,
        animatedIconData: AnimatedIcons.menu_close,
        fabButtons: [
          FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                controller.handleAddButton(context);
              }),
          FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                controller.getLocation().then((value) => print(value));
              }),
          FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                controller.logout();
              })
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<LatLng>(
                future: controller.getCurrentLatLng(),
                builder: (context, snapshot) {
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

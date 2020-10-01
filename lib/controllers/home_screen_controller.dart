import 'package:dog_tracker/controllers/auth_controller.dart';
import 'package:dog_tracker/screens/home/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class HomeScreenController extends GetxController {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location location = new Location();
  LocationData _locationData;

  ///Check Permissions function adapted from the quick start guide of the
  ///location package.
  void _checkPermissions() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  ///Get the current device location
  Future<LocationData> getLocation() async {
    _checkPermissions();
    _locationData = await location.getLocation();
    return _locationData;
  }

  ///Returns the current Latitude and Longitude using the the getLocation() method
  ///in a LatLng object usable by GoogleMaps
  Future<LatLng> getCurrentLatLng() async {
    LocationData _location = await getLocation();
    return LatLng(_location.latitude, _location.longitude);
  }

  void locationStream() async {
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
    });
  }

  ///logs the user out
  void logout() async {
    final AuthController _controller = Get.find();
    _controller.signOut();
  }

  ///shows the AddBottomSheet when the user presses it. Takes in a BuildContext
  ///from the parent as an argument
  void handleAddButton(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: (context),
        builder: (context) {
          return AddButtonBottomSheet();
        });
  }
}

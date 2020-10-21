import 'dart:async';
import 'dart:collection';
import 'package:dog_tracker/controllers/auth_controller.dart';
import 'package:dog_tracker/models/gps_device_model.dart';
import 'package:dog_tracker/services/api/device.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class HomeScreenController extends GetxController {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location location = Location();
  LocationData _locationData;
  RxInt bottomNavIndex = 0.obs;
  Rx<Marker> _currentMarker = Marker(markerId: MarkerId("0")).obs;
  Rx<Set<Marker>> _markers = HashSet<Marker>().obs;

  Rx<Set<Marker>> get markers => _markers;

  void changeBottomNav(int index) {
    bottomNavIndex.value = index;
    bottomNavIndex.refresh();
    print(bottomNavIndex.value);
  }

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

  void setCurrentMapMarker() async {
    GPSDeviceModel thisDevice = await DeviceHelpers.getThisDeviceInfo();
    _currentMarker.value = Marker(
      markerId: MarkerId(thisDevice.deviceID),
      position: await getCurrentLatLng(),
    );
    _currentMarker.refresh();
    _markers.value.clear();
    _markers.value.add(_currentMarker.value);
    _markers.refresh();
  }

  ///logs the user out
  void logout() async {
    final AuthController _controller = Get.find();
    _controller.signOut();
  }
}

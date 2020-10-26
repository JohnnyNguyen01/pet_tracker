import 'dart:async';
import 'dart:collection';
import 'package:dog_tracker/controllers/auth_controller.dart';
import 'package:dog_tracker/models/gps_device_model.dart';
import 'package:dog_tracker/services/api/device.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class HomeScreenController extends GetxController {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location location = Location();
  Rx<LocationData> _locationData =
      LocationData.fromMap({'latitude': 0.0, 'longitude': 0.0}).obs;
  RxInt bottomNavIndex = 0.obs;
  BitmapDescriptor _customPin;
  Rx<Marker> _currentMarker = Marker(markerId: MarkerId("0")).obs;
  Rx<Set<Marker>> _markers = HashSet<Marker>().obs;
  Rx<Set<Marker>> get markers => _markers;

  @override
  void onInit() async {
    super.onInit();
    setCustomMapPin();
    _checkPermissions();
    await getCurrentLocation();
    //todo: Uncomment after testing getLatestGeoPoint
    // if (await Device.thisDeviceIsDBGps()) {
    //   Timer.periodic(const Duration(seconds: 1), (timer) {
    //     setCurrentMapMarker();
    //     Device.uploadLocationEveryTenSeconds();
    //   });
    // }
  }

  ///Sets up a custom pin for Google Maps
  void setCustomMapPin() async {
    _customPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "lib/assets/images/corgi_pin_250x155.png");
  }

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
  Future<LocationData> getCurrentLocation() async {
    _locationData.value = await location.getLocation();
    _locationData.refresh();
    return _locationData.value;
  }

  ///Returns the current Latitude and Longitude using the the getLocation() method
  ///in a LatLng object usable by GoogleMaps
  Future<LatLng> getCurrentLatLng() async {
    await getCurrentLocation();
    return LatLng(_locationData.value.latitude, _locationData.value.longitude);
  }

  ///Update the current map marker for this device.
  void setCurrentMapMarker() async {
    GPSDeviceModel thisDevice = await Device.getThisDeviceInfo();
    _currentMarker.value = Marker(
        markerId: MarkerId(thisDevice.deviceID),
        position: await getCurrentLatLng(),
        icon: _customPin);
    print(await getCurrentLatLng());
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

  @override
  FutureOr onClose() {
    // TODO: implement onClose
    _locationData.close();
    _currentMarker.close();
    _markers.close();
    return super.onClose();
  }
}

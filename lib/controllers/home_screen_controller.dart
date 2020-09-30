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

  void locationStream() async {
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
    });
  }
}

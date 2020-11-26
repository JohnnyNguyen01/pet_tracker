import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_tracker/controllers/auth_controller.dart';
import 'package:dog_tracker/models/gps_device_model.dart';
import 'package:dog_tracker/services/api/device.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import '../services/api/database.dart';

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
  //for polyline routes
  RxSet<Polyline> polyLines = <Polyline>{}.obs;
  RxList<LatLng> _polylineCoordinates = <LatLng>[].obs;
  Rx<PolylinePoints> polylinePoints = PolylinePoints().obs;

  Rx<Set<Marker>> get markers => _markers;
  Timer _timer;

  @override
  void onInit() async {
    super.onInit();
    setCustomMapPin();
    _checkPermissions();
    await location.changeSettings(accuracy: LocationAccuracy.high);
    await getCurrentLocation();
  }

  @override
  void onReady() async {
    // TODO: uncomment to upload location. Use Geopoints from firebase to update marker location
    super.onReady();
    if (await Device.thisDeviceIsDBGps()) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // setCurrentMapMarker();
        setAllGPSMapMarkers();
        // Device.uploadLocationEveryTenSeconds();
        setPolyLines();
      });
    }
  }

  //todo: refactor and redo [setPolyLines, createPolyLines]
  void setPolyLines() async {
    LatLng currentLatLng = await getCurrentLatLng();
    PointLatLng currentPointLatLng =
        PointLatLng(currentLatLng.latitude, currentLatLng.longitude);
    List<GeoPoint> geoPoints =
        await Database.db.getLatestGeoPointOfAllDevices();
    await Future.forEach(geoPoints, (geoPoint) async {
      if (geoPoint != null) {
        PolylineResult result = await polylinePoints.value
            .getRouteBetweenCoordinates(
                'AIzaSyAr31utYalU_q4_Lh1GtqZrCDgg0VBlcHI',
                currentPointLatLng,
                PointLatLng(geoPoint.latitude, geoPoint.longitude));
        if (result != null) {
          result.points.forEach((PointLatLng point) {
            _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            _polylineCoordinates.refresh();
            createPolyLines();
          });
        }
      }
    });
  }

  ///Creates the actual polylines, must be used in setPolyLines method
  ///todo: refactor and redo [setPolyLines, createPolyLines]
  void createPolyLines() {
    Polyline polyline = Polyline(
        polylineId: PolylineId("poly"),
        color: Color.fromARGB(255, 40, 122, 198),
        points: _polylineCoordinates);
    polyLines.add(polyline);
    polyLines.refresh();
  }

  ///Sets up a custom pin for Google Maps
  void setCustomMapPin() async {
    _customPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "lib/assets/images/corgi_pin_250x155.png");
  }

  ///Responsible for changing the bottom navbar element on user tap
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

  void setAllGPSMapMarkers() async {
    //grt all devices
    List<GeoPoint> deviceGeoPoints =
        await Database.db.getLatestGeoPointOfAllDevices();
    // print("setAllGPSMarkers: ${deviceGeoPoints.length}");
    //get their latest coordinates from firebase
    //set map marker
    // print(deviceGeoPoints);
    if (deviceGeoPoints.isNotEmpty)
      deviceGeoPoints.forEach((geoPoint) {
        if (geoPoint != null) {
          _markers.value.add(Marker(
              markerId: MarkerId(geoPoint.toString()),
              position: LatLng(geoPoint.latitude, geoPoint.longitude),
              icon: _customPin));
          _markers.refresh();
        }
      });
    // print(_markers.value);
  }

  ///logs the user out
  void logout() async {
    final AuthController _controller = Get.find();
    _controller.signOut();
  }

  @override
  FutureOr onClose() {
    _locationData.close();
    _currentMarker.close();
    _markers.close();
    _timer.cancel();
    return super.onClose();
  }
}

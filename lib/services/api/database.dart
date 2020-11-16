import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_tracker/models/gps_device_model.dart';
import 'package:dog_tracker/models/pet_model.dart';
import '../../models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final Database db = Database();

  ///Creates a new user Document in the firebase `users` collection
  ///with id, email and name fields.
  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection("users")
          .doc(user.uid)
          .set({'id': user.uid, 'email': user.email, 'name': user.name});
      return true;
    } catch (error) {
      //todo: add error case
      print(error);
      return false;
    }
  }

  ///Retrieve the selected user from Firebase.
  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(doc);
    } catch (error) {
      //todo: add error case for getUser
      print(error);
      rethrow;
    }
  }

  Future<void> createNewPet(PetModel pet) async {
    try {
      await _firestore
          .collection("pets")
          .doc(pet.id.toString())
          .set({'id': pet.id.toString(), 'name': pet.name, 'type': pet.type});
    } catch (error) {
      print(error);
    }
  }

  ///Add a new GPS Device to Firestore in order to check whether a device is a
  ///GPS or not.
  Future<void> addNewGPS(GPSDeviceModel device) async {
    try {
      await _firestore
          .collection("GPSDevices")
          .doc(device.deviceID.toString())
          .set({
        'deviceID': device.deviceID,
        'deviceName': device.deviceName,
      });
    } catch (error) {
      print(error);
    }
  }

  ///Checks if the current user device is designated as a GPS from Firebase.
  ///[deviceID] refers to this deviceID as a string
  Future<bool> thisDeviceIsGPS(String deviceID) async {
    bool result;
    try {
      await _firestore
                  .collection("GPSDevices")
                  .where("deviceID", isEqualTo: deviceID)
                  .limit(1)
                  .get() !=
              null
          ? result = true
          : result = false;
    } catch (e) {
      result = false;
      print(e);
    }
    return result;
  }

  ///Returns a List of `GPSDeviceModel` containting all of the gps devices from
  ///Firebase
  Future<List<GPSDeviceModel>> getAllGPSDevicesOf() async {
    List<GPSDeviceModel> deviceList = <GPSDeviceModel>[];
    QuerySnapshot snapshot = await _firestore.collection('GPSDevices').get();
    snapshot.docs.forEach((device) {
      deviceList.add(GPSDeviceModel.fromJson(device.data()));
    });
    return deviceList;
  }

  ///Returns a List of the latest `GeoPoint` for each GPS device subscribed to
  ///firebase that has at least one geopoint uploaded
  Future<List<GeoPoint>> getLatestGeoPointOfAllDevices() async {
    try {
      List<GeoPoint> geoPointList = <GeoPoint>[];
      List<GPSDeviceModel> devices = await getAllGPSDevicesOf();
      // devices.forEach((device) async {
      //   GeoPoint point = await getLatestGeopointOfDevice(device.deviceID);
      //   geoPointList.add(point);
      // });
      await Future.forEach(devices, (device) async {
        if (device != null) {
          GeoPoint point = await getLatestGeopointOfDevice(device.deviceID);
          geoPointList.add(point);
        }
      });
      print(geoPointList);
      return geoPointList;
    } catch (e) {
      // print("getLatestGeoPointOfAllDevices errro : $e");
      return null;
    }
  }

  ///Upload this device's coordinates into firestore under the specific
  ///deviceID. Latitude and Longitude are stored as a `Geopoint` data
  ///type in firestore
  Future<void> uploadCurrentGPSLocation(
      String deviceID, double latitude, double longitude) async {
    try {
      await _firestore
          .collection("DeviceCoordinates")
          .doc(deviceID)
          .collection("LatLng")
          .add({
        "coordinates": GeoPoint(latitude, longitude),
        'date-time': DateTime.now()
      });
    } catch (error) {
      print("uploadCurrentGPSLocation Error: $error");
    }
  }

  ///Returns the latest `Geopoint` of the selected deviceID from firestore
  Future<GeoPoint> getLatestGeopointOfDevice(String deviceID) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("DeviceCoordinates")
          .doc(deviceID)
          .collection("LatLng")
          .orderBy("date-time", descending: true)
          .limit(1)
          .get();
      QueryDocumentSnapshot docSnapshot = snapshot.docs.first;
      return docSnapshot.data()["coordinates"];
    } catch (e) {
      print(e);
      return null;
    }
  }
}

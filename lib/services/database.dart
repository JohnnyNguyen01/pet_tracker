import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_tracker/models/gps_device_model.dart';
import 'package:dog_tracker/models/pet_model.dart';
import '../models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final Database db = Database();

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
          .set({'deviceID': device.deviceID, 'deviceName': device.deviceName});
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

  Future<void> uploadCurrentGPSLocation(
      String deviceID, double latitude, double longitude) async {
    try {
      _firestore
          .collection("DeviceCoordinates")
          .doc(deviceID)
          .collection("LatLng")
          .add({'latitude': latitude, 'longitude': longitude});
    } catch (error) {
      print(error);
    }
  }
}

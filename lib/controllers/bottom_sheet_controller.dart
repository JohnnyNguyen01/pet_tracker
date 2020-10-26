import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:dog_tracker/models/gps_device_model.dart';
import 'package:dog_tracker/models/pet_model.dart';
import 'package:dog_tracker/services/api/device.dart';
import 'package:dog_tracker/services/database.dart';
import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  RxBool _isGps = false.obs;
  RxBool getIsGps() => _isGps;
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  void handleSubmitButton(String petName, String petType) async {
    PetModel _pet =
        PetModel(id: Random.secure().nextInt(5), name: petName, type: petType);
    await Database.db.createNewPet(_pet);

    //todo: implement _isGPS.value == true || Current solution is ugly
    if (_isGps.value == true) {
      GPSDeviceModel _thisDevice;
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;

        _thisDevice = GPSDeviceModel(
          deviceID: androidInfo.androidId,
          deviceName: androidInfo.device,
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _thisDevice = GPSDeviceModel(
          deviceID: iosInfo.identifierForVendor,
          deviceName: iosInfo.name,
        );
      }
      await Database.db.addNewGPS(_thisDevice);
    }
  }

  void handleGPSToggleBtn(bool value) {
    _isGps.value = value;
    _isGps.refresh();
  }

  void handleTestBtn() async {
    GPSDeviceModel thisDevice = await Device.getThisDeviceInfo();
    GeoPoint result =
        await Database.db.getLatestGeopointOfDevice(thisDevice.deviceID);
    print(result.latitude);
  }
}

import 'dart:io';
import 'dart:math';
import 'package:device_info/device_info.dart';
import 'package:dog_tracker/models/gps_device_model.dart';
import 'package:dog_tracker/models/pet_model.dart';
import 'package:dog_tracker/services/database.dart';
import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  RxBool _isGps = false.obs;
  RxBool getIsGps() => _isGps;
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  void handleSubmitButton(String petName, String petType) async {
    PetModel _pet =
        PetModel(id: Random.secure().nextInt(5), name: petName, type: petType);
    // await Database.db.createNewPet(_pet);
    //todo: implement _isGPS.value == true || Current solution is ugly
    if (_isGps.value == true) {
      String deviceID;
      String model;

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        deviceID = androidInfo.androidId;
        model = androidInfo.device;
        print(
            "This device is ${androidInfo.androidId} and is a ${androidInfo.device}");
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        print("this device is ${iosInfo.name} a ${iosInfo.model}");
      }
      //Database.db.addNewGPS(device);
      print(GPSDeviceModel(deviceID: deviceID, deviceName: model).toString());
    }
  }

  void handleGPSToggleBtn(bool value) {
    _isGps.value = value;
    _isGps.refresh();
    print(_isGps.value);
  }
}

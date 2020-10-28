import 'dart:async';
import 'dart:io';
import 'package:dog_tracker/models/gps_device_model.dart';
import 'package:device_info/device_info.dart';
import 'package:location/location.dart';

import 'database.dart';

class Device {
  static DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  ///Returns the device info with all the parameters indicated within
  ///[GPSDeviceModel]
  static Future<GPSDeviceModel> getThisDeviceInfo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return GPSDeviceModel(
        deviceID: androidInfo.androidId,
        deviceName: androidInfo.device,
      );
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return GPSDeviceModel(
        deviceID: iosInfo.identifierForVendor,
        deviceName: iosInfo.name,
      );
    } else {
      return null;
    }
  }

  ///Uploads this device's location to firebase every 10 seconds
  static void uploadLocationEveryTenSeconds() async {
    Location location = Location();
    const tenSeconds = const Duration(seconds: 10);
    GPSDeviceModel device = await Device.getThisDeviceInfo();
    Timer.periodic(tenSeconds, (timer) {
      location.onLocationChanged.listen((LocationData currentLocation) {
        Database.db.uploadCurrentGPSLocation(device.deviceID,
            currentLocation.latitude, currentLocation.longitude);
      });
    });
  }

  ///Obtain whether this device is designated as a GPS Device within Firebase.
  ///Returns a `bool`
  static Future<bool> thisDeviceIsDBGps() async {
    bool result;
    GPSDeviceModel thisDevice = await getThisDeviceInfo();
    result = await Database.db.thisDeviceIsGPS(thisDevice.deviceID);
    print('thisDeviceIsDBGPS result is: $result');
    return result;
  }
}

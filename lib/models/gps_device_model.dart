import 'package:flutter/foundation.dart';

class GPSDeviceModel {
  String deviceID;
  String deviceName;

  GPSDeviceModel({@required this.deviceID, @required this.deviceName});

  GPSDeviceModel.fromJson(Map<String, dynamic> json) {
    this.deviceID = json['deviceID'];
    this.deviceName = json['deviceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceID'] = this.deviceID;
    data['deviceName'] = this.deviceName;
    return data;
  }

  @override
  String toString() {
    return "The devcieID: $deviceID || The deviceName: $deviceName";
  }
}

import 'dart:math';

import 'package:dog_tracker/models/pet_model.dart';
import 'package:dog_tracker/services/database.dart';
import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  RxBool _isGps = false.obs;
  RxBool getIsGps() => _isGps;

  void handleSubmitButton(String petName, String petType) async {
    PetModel _pet =
        PetModel(id: Random.secure().nextInt(5), name: petName, type: petType);
    await Database.db.createNewPet(_pet);
    //todo: implement _isGPS.value == true
  }

  void handleGPSToggleBtn(bool value) {
    _isGps.value = value;
    _isGps.refresh();
    print(_isGps.value);
  }
}

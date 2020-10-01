import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  RxBool _isGps = false.obs;

  RxBool getIsGps() => _isGps;

  void handleGPSToggleBtn(bool value) {
    _isGps.value = value;
    _isGps.refresh();
    print(_isGps.value);
  }
}

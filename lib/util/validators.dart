import 'package:get/utils.dart';

class ValidationMixin {
  String validateEmail(String text) {
    if (!GetUtils.isEmail(text)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String validatePetName(String text) {
    if (text.length == 0 || text.length == null) {
      return "Please enter a pet name";
    }
    return null;
  }
}

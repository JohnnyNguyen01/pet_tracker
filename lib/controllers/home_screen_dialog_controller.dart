import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DialogBoxController extends GetxController {
  Rx<File> _image = File("").obs;
  final _picker = ImagePicker();

  File get image => _image.value;

  ///Grab the Image from the camera
  Future getImageFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    _image.update((file) {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        return print("No image selected.");
      }
    });
  }
}

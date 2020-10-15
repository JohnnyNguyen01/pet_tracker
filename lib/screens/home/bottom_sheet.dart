import 'package:dog_tracker/controllers/bottom_sheet_controller.dart';
import 'package:dog_tracker/controllers/home_screen_dialog_controller.dart';
import 'package:dog_tracker/screens/home/dialog_box.dart';
import 'package:dog_tracker/util/constants.dart';
import 'package:dog_tracker/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddButtonBottomSheet extends GetWidget<BottomSheetController>
    with ValidationMixin {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petTypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // controller binding
    Get.lazyPut(() => BottomSheetController());
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 1.0,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Form(
                child: Column(
                  children: [
                    Text(
                      "Add Pet",
                      style: Constants.h2,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Pet Name"),
                      controller: _petNameController,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Pet Type"),
                      controller: _petTypeController,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text("Make this device the GPS"),
                        Obx(
                          () => Switch(
                            onChanged: (value) =>
                                controller.handleGPSToggleBtn(value),
                            value: controller.getIsGps().value,
                          ),
                        ),
                      ],
                    ),
                    // Stack(
                    //   alignment: Alignment.center,
                    //   overflow: Overflow.visible,
                    //   children: [
                    //     Obx(
                    //       () => CircleAvatar(
                    //         radius: 60,
                    //         backgroundImage:
                    //             FileImage(Get.put(DialogBoxController()).image),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       child: IconButton(
                    //         icon: Icon(
                    //           Icons.add_a_photo,
                    //           size: 40,
                    //         ),
                    //         onPressed: () {
                    //           Get.dialog(DialogBox());
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Submit",
                          style: Constants.poppinsWhiteText,
                        ),
                        onPressed: () {
                          controller.handleSubmitButton(
                              _petNameController.text, _petTypeController.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

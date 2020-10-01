import 'package:dog_tracker/controllers/bottom_sheet_controller.dart';
import 'package:dog_tracker/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddButtonBottomSheet extends GetWidget<BottomSheetController> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petTypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
                  CircleAvatar(
                    radius: 30,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

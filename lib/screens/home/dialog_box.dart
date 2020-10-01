import 'package:dog_tracker/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogBox extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      child: Container(
        height: 250,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Where would you like to upload a photo from?",
              style: Constants.dialogTitle,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Camera",
                      style: Constants.poppinsWhiteText,
                    ),
                    onPressed: () {}),
                SizedBox(width: 15),
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Gallery",
                      style: Constants.poppinsWhiteText,
                    ),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

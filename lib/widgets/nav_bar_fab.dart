import 'package:dog_tracker/screens/home/bottom_sheet.dart';
import 'package:flutter/material.dart';

class NavBarFABButton extends StatelessWidget {
  ///shows the AddBottomSheet when the user presses it. Takes in a BuildContext
  ///from the parent as an argument
  void handleAddButton(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: (context),
        builder: (context) {
          return AddButtonBottomSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => handleAddButton(context),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

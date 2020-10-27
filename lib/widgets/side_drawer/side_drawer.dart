import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SideDrawer extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
          ),
          ListTile(
            title: Text("test tile"),
            onTap: () {},
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }
}

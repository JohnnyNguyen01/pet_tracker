import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;

  UserModel({
    this.uid,
    this.name,
    this.email,
  });

  UserModel.fromDocumentSnapshot(DocumentSnapshot docSnapshot) {
    uid = docSnapshot.data()['uid'];
    this.name = docSnapshot.data()['name'];
    this.email = docSnapshot.data()['email'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}

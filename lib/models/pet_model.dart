import 'package:cloud_firestore/cloud_firestore.dart';

class PetModel {
  int id;
  String name;
  String type;

  PetModel({this.id, this.name, this.type});

  PetModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.data()['id'];
    this.name = snapshot.data()['name'];
    this.type = snapshot.data()['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

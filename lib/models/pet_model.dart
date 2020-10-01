import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  int id;
  String name;

  Pet({this.id, this.name});

  Pet.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.data()['id'];
    this.name = snapshot.data()['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

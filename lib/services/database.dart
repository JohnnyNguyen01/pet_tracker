import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_tracker/models/pet_model.dart';
import '../models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final Database db = Database();

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection("users")
          .doc(user.uid)
          .set({'id': user.uid, 'email': user.email, 'name': user.name});
      return true;
    } catch (error) {
      //todo: add error case
      print(error);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(doc);
    } catch (error) {
      //todo: add error case for getUser
      print(error);
      rethrow;
    }
  }

  Future<void> createNewPet(PetModel pet) async {
    try {
      await _firestore
          .collection("pets")
          .doc(pet.id.toString())
          .set({'id': pet.id.toString(), 'name': pet.name, 'type': pet.type});
    } catch (error) {
      print(error);
    }
  }
}

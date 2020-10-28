import 'package:dog_tracker/controllers/user_controller.dart';
import 'package:dog_tracker/models/user_model.dart';
import 'package:dog_tracker/screens/home/home_screen.dart';
import 'package:dog_tracker/services/api/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User> _firebaseUser = Rx<User>();
  User get user => _firebaseUser.value;

  ///Create a new User for the app
  ///
  /// String [name] :  name of the the new suer
  ///
  /// String [password] : password of the new user
  ///
  /// String [email] : email address  of the new user
  ///
  /// throws a [FirebaseAuthException] error in a snackbar if the attempt is
  /// unsuccessful
  void handleSignUpButton(String name, String password, String email) async {
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User _user = _userCredential.user;
      UserModel _userModel = UserModel(
        uid: _user.uid,
        name: name,
        email: email,
      );
      await Database.db.createNewUser(_userModel);
      Get.find<UserController>().user = _userModel;
      Get.off(HomeScreen());
    } catch (FirebaseAuthException) {
      Get.snackbar("Error", FirebaseAuthException.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {}
  }

  ///Signs out the currently logged in user, if there's an error then
  ///a snackbar shows the user the error
  void signOut() async {
    try {
      _auth.signOut();
      Get.find<UserController>().clear();
    } catch (error) {
      Get.snackbar("Sign out Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

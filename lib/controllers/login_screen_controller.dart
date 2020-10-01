import 'package:dog_tracker/controllers/user_controller.dart';
import 'package:dog_tracker/screens/home/home_screen.dart';
import 'package:dog_tracker/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User> _firebaseUser = Rx<User>();
  User get user => _firebaseUser.value;

  @override
  void onInit() async {
    //checks to see if the user signs in or out, using the FirebaseAuth Singleton
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  ///Signs in a new user ,
  ///
  /// {String} email - the user's email address
  ///
  /// {String} password - user's account password
  ///
  ///if there's an error then a snackbar shows the user the error
  void login(String email, String password) async {
    try {
      UserCredential _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.find<UserController>().user =
          await Database.db.getUser(_user.user.uid);
      Get.off(HomeScreen());
    } catch (FirebaseExceptionError) {
      Get.snackbar("Login Error", FirebaseExceptionError);
      rethrow;
    }
  }
}

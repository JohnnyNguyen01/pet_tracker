import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _authInstnace = FirebaseAuth.instance;
  static Auth instance = Auth();

  ///Signs outs the current user
  Future<void> logOutCurrentUser() async {
    try {
      await _authInstnace.signOut();
    } catch (error) {
      rethrow;
    }
  }

  ///Change the current signed in User's password
  Future<void> changeCurrentUserPassword(String password) async {
    try {
      await _authInstnace.currentUser.updatePassword(password);
    } catch (e) {
      print(e);
    }
  }

  //TODO: finish this method to move on with Dialog Screen
  ///Retrieve the password of the currently signed in user
  Future<String> getCurrentUserPassword() async {}
}

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
}

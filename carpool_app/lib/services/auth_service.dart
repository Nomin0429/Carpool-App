import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser == null) {
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      log('nomiooo $gAuth');
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user == null) {
        return null;
      }

      return user;
    } catch (error) {
      return null;
    }
  }
}

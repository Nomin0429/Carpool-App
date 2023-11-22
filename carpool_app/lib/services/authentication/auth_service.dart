import 'dart:developer';

import 'package:carpool_app/home/view/home_screen.dart';
import 'package:carpool_app/login/view/welcome_screen.dart';
import 'package:carpool_app/services/exceptions/signup_email_password_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  static AuthService get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (callback) => _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => HomeScreen());
  }

  Future<void> registerEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => HomeScreen()) : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailPasswordFailure.code(e.code);
      log('FireBase auth exception: ${ex.message}');
      throw ex;
    }
  }

  Future<void> signInEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}

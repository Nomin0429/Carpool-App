import 'dart:developer';
import 'package:carpool_app/login/view/login_screen.dart';
import 'package:carpool_app/signup/state/signup_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../home/view/home_screen.dart';
import '../../login/view/welcome_screen.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final SignUpState state = SignUpState();

  final email = TextEditingController();
  final name = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  bool isValidEmail(String email) {
    Pattern pattern =
        r'^(([^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(email);
  }

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (callback) => _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => const HomeScreen());
  }

  ///Хэрэглэгч бүртгэх функц
  Future<bool> registerEmailAndPassword(String email, String password, String name, String phoneNumber) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      // Get the current user
      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'phone': phoneNumber,
          'email': email,
          'role': 'rider',
          'joinedAt': FieldValue.serverTimestamp(),
          'cars': [],
          'rideHistory': {},
        });

        // Navigate to the HomeScreen
        Get.offAll(() => const HomeScreen());
        return true;
      } else {
        // Navigate to the LoginScreen
        Get.to(() => LoginScreen());
        return false;
      }
    } on FirebaseAuthException catch (e) {
      log('Firebase auth exception: ${e.message}');
      return false;
    } catch (e) {
      log('General exception: $e');
      return false;
    }
  }
}

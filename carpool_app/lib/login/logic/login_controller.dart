import 'package:carpool_app/login/state/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();
  final _auth = FirebaseAuth.instance;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> signInEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
      return true;
    } catch (_) {
      return false;
    }
  }

  void toggleObsecureText() {
    state.obscureText.value = !state.obscureText.value;
  }

  Future<dynamic> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await location.requestService();

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    locationData = await location.getLocation();
    return locationData;
  }
}

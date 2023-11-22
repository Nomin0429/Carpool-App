import 'package:carpool_app/services/authentication/auth_service.dart';
import 'package:carpool_app/signup/state/signup_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final SignUpState state = SignUpState();

  final email = TextEditingController();
  final name = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();

  Future<bool> registerUser(String email, String password) async {
    try {
      await AuthService.instance.registerEmailAndPassword(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }
}

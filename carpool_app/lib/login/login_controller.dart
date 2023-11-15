import 'package:carpool_app/login/login_state.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();

  void toggleObsecureText() {
    state.obscureText.value = !state.obscureText.value;
  }
}

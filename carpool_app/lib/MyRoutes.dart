import 'package:carpool_app/login/login_binding.dart';
import 'package:carpool_app/login/login_screen.dart';
import 'package:carpool_app/routes.dart';
import 'package:carpool_app/signup/signup_binding.dart';
import 'package:carpool_app/signup/signup_screen.dart';
import 'package:get/get.dart';

import 'login/welcome_screen.dart';

class MyRoutes {
  static final routes = [
    GetPage(name: Routes.welcome, page: () => const WelcomeScreen(), binding: LoginBinding()),
    GetPage(name: Routes.login, page: () => const LoginScreen(), binding: LoginBinding()),
    GetPage(name: Routes.register, page: () => const SignUpScreen(), binding: SignUpBinding()),
  ];
}

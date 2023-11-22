import 'package:carpool_app/home/logic/home_binding.dart';
import 'package:carpool_app/home/view/home_screen.dart';
import 'package:carpool_app/login/logic/login_binding.dart';
import 'package:carpool_app/login/view/login_screen.dart';
import 'package:carpool_app/routes.dart';
import 'package:carpool_app/signup/logic/signup_binding.dart';
import 'package:carpool_app/signup/view/signup_screen.dart';
import 'package:get/get.dart';

import 'login/view/welcome_screen.dart';

class MyRoutes {
  static final routes = [
    GetPage(
      name: Routes.welcome,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(name: Routes.register, page: () => const SignUpScreen(), binding: SignUpBinding()),
    GetPage(name: Routes.homeScreen, page: () => HomeScreen(), binding: HomeBinding()),
  ];
}

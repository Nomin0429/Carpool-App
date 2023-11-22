import 'dart:developer';
import 'package:carpool_app/home/view/home_screen.dart';
import 'package:carpool_app/login/view/welcome_screen.dart';
import 'package:carpool_app/onBoarding/onBoarding_screen.dart';
import 'package:carpool_app/routes.dart';
import 'package:carpool_app/services/authentication/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/logic/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp().then((value) => Get.put(AuthService()));
    runApp(const MyApp());
  } catch (e) {
    log("Firebase initialization failed: $e");
  }

  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: Routes.onBoarding,
        getPages: [
          GetPage(name: Routes.onBoarding, page: () => const OnBoardingScreen()),
        ],
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Get.lazyPut(() => HomeController());
              return HomeScreen();
            } else {
              return const WelcomeScreen();
            }
          },
        ));
  }
}

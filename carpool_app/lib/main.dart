import 'dart:developer';

import 'package:carpool_app/login/welcome_screen.dart';
import 'package:carpool_app/onBoarding/onBoarding_screen.dart';
import 'package:carpool_app/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login/login_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(const MyApp());
  } catch (e) {
    log("Firebase initialization failed: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(initialRoute: Routes.onBoarding, getPages: [
      GetPage(name: Routes.onBoarding, page: () => const OnBoardingScreen(), binding: LoginBinding()),
    ]);
  }
}

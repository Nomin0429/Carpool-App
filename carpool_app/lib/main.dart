// import 'dart:developer';
// import 'package:carpool_app/home/view/home_screen.dart';
// import 'package:carpool_app/login/view/welcome_screen.dart';
// import 'package:carpool_app/onBoarding/onBoarding_screen.dart';
// import 'package:carpool_app/routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'home/logic/home_controller.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp().then((value) => Get.put(()));
//     runApp(const MyApp());
//   } catch (e) {
//     log("Firebase initialization failed: $e");
//   }
//
//   //runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//         initialRoute: Routes.onBoarding,
//         getPages: [
//           GetPage(name: Routes.onBoarding, page: () => const OnBoardingScreen()),
//         ],
//         home: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               Get.lazyPut(() => HomeController());
//               return const HomeScreen();
//             } else {
//               return const WelcomeScreen();
//             }
//           },
//         ));
//   }
// }
import 'package:carpool_app/login/view/login_screen.dart';
import 'package:carpool_app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/logic/home_controller.dart';
import 'home/view/home_screen.dart';
import 'onBoarding/onBoarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: Routes.onBoarding, page: () => const OnBoardingScreen()),
        // Add other routes as needed
      ],
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // User is logged in
              return const HomeScreen();
            } else {
              // User is not logged in, check onboarding status
              return _buildOnBoardingChecker();
            }
          }
          // Show loading indicator while waiting for connection
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildOnBoardingChecker() {
    return FutureBuilder<bool>(
      future: shouldShowOnBoarding(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data ?? false) {
            // Onboarding has been seen, show LoginScreen
            return LoginScreen();
          } else {
            // Onboarding not seen, show OnBoardingScreen
            return const OnBoardingScreen();
          }
        }
        // Show loading indicator while waiting for future
        return const CircularProgressIndicator();
      },
    );
  }

  Future<bool> shouldShowOnBoarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seen_onboarding') ?? false;
  }
}

import 'package:carpool_app/login/view/login_screen.dart';
import 'package:carpool_app/signup/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../style/AppColors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 180, right: 50, left: 50),
        child: Column(
          children: [
            Image.asset('assets/images/welcomeScreen.png'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Тавтай морил',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(
              height: 240,
            ),
            SizedBox(
                height: 45,
                width: 310,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const SignUpScreen());
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primary700,
                      ),
                      elevation: MaterialStateProperty.all(0.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
                  child: const Text(
                    'Бүртгүүлэх',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            const SizedBox(height: 15),
            SizedBox(
                height: 45,
                width: 310,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: AppColors.primary700)))),
                    child: const Text(
                      'Нэвтрэх',
                      style: TextStyle(color: AppColors.primary700),
                    ))),
          ],
        ),
      ),
    );
  }
}

import 'package:carpool_app/login/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/AppColors.dart';

class OnBoardingScreen3 extends StatelessWidget {
  const OnBoardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.to(const WelcomeScreen());
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(height: 200, child: Image.asset('assets/images/onBoarding3.png')),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Book your car',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Sell houses easily with the help of Listenoryx and to make this line big I am writing more.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 170,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const WelcomeScreen());
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary500,
                  onPrimary: Colors.white, // Text color
                  shape: const CircleBorder(), // Make the button a circle
                  padding: const EdgeInsets.all(24), // Button size
                ),
                child: const Text('Go'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

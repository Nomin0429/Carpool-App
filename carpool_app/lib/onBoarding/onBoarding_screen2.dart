import 'package:carpool_app/login/view/login_screen.dart';
import 'package:carpool_app/onBoarding/onBoarding_screen3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/AppColors.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await setOnboardingSeen();
              Get.to(LoginScreen());
            },
            child: const Text(
              'Алгасах',
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
            SizedBox(height: 200, child: Image.asset('assets/images/onBoarding2.png')),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Унаа санал болгох',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Ажилдаа явахдаа, гэртээ харихдаа ижил зүгт явах хүмүүсийг дайгаад нэмэлт орлого олох боломжтой.',
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
                  Get.to(const OnBoardingScreen3());
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primary500,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                ),
                child: const Icon(Icons.arrow_forward),
              ),
            )
          ],
        ),
      ),
    );
  }
}

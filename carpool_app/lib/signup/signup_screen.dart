import 'package:carpool_app/signup/signup_controller.dart';
import 'package:carpool_app/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/AppColors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpState state = SignUpController().state;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image(
                      height: 14,
                      image: AssetImage('assets/icons/angleLeft.png'),
                    ),
                  ),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sign up with your email or phone number',
                style: TextStyle(fontSize: 27),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 70,
              width: 360,
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    hintText: 'Name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ),
            SizedBox(
              height: 70,
              width: 360,
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ),
            SizedBox(
              height: 70,
              width: 360,
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    hintText: 'Enter your phone number',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ),
            SizedBox(
              height: 70,
              width: 360,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    hintText: 'Gender',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                onChanged: (String? newValue) {
                  state.userGender = newValue!;
                },
                items: <String>['Female', 'Male'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: 340,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary700),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))),
                  child: const Text('Register', style: TextStyle(fontSize: 15)),
                ),
              ),
            ),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: Text('or', style: TextStyle(fontSize: 15, color: Colors.black12)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: 350,
                height: 45,
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/Gmail.png',
                      height: 20,
                    ),
                    label: const Text(
                      'Sign up with Gmail',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black12, width: 1),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: 350,
                height: 45,
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/Facebook.png',
                      height: 20,
                    ),
                    label: const Text(
                      'Sign up with Facebook',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black12, width: 1),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: 350,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/Apple.png',
                    height: 20,
                  ),
                  label: const Text(
                    'Sign up with Apple',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black12, width: 1.0),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

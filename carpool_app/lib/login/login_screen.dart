import 'package:carpool_app/home/home_screen.dart';
import 'package:carpool_app/login/login_controller.dart';
import 'package:carpool_app/login/login_state.dart';
import 'package:carpool_app/services/auth_service.dart';
import 'package:carpool_app/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/AppColors.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginState state = controller.state;
    TextEditingController passwordController = TextEditingController();

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
            const SizedBox(height: 37),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Sign in with your email or phone number',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 46,
            ),
            SizedBox(
              height: 70,
              width: 370,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  hintText: 'Email or Phone Number',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black12),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              width: 370,
              child: Obx(
                () => TextFormField(
                  controller: passwordController,
                  obscureText: state.obscureText.value,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(18),
                      hintText: 'Enter Your Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder:
                          OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Colors.black12), borderRadius: BorderRadius.circular(8.0)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.obscureText.value ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          controller.toggleObsecureText();
                        },
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0), // You can adjust the padding as needed
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.error800),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: 340,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const HomeScreen());
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary700),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))),
                  child: const Text('Login', style: TextStyle(fontSize: 15)),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  const Text('Do not have an account?'),
                  TextButton(
                      onPressed: () {
                        Get.to(const SignUpScreen());
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: AppColors.primary700),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

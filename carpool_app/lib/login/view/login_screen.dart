import 'package:carpool_app/home/view/components/go_back_button.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/home_screen.dart';
import 'package:carpool_app/login/logic/login_controller.dart';
import 'package:carpool_app/login/state/login_state.dart';
import 'package:carpool_app/signup/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/view/components/success_dialog_widget.dart';
import '../../style/AppColors.dart';

class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    LoginState state = controller.state;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
          child: Column(
            children: [
              const GoBackButton(),
              const SizedBox(height: 37),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Нэвтрэх',
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
                  controller: loginController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Имейлээ оруулна уу!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    hintText: 'Имейл',
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
                    controller: loginController.passwordController,
                    obscureText: state.obscureText.value,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18),
                        hintText: 'Нууц үг',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.black12), borderRadius: BorderRadius.circular(8.0)),
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
                  padding: const EdgeInsets.only(top: 0.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Нууц үгээ мартсан уу?',
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
                    onPressed: () async {
                      Get.lazyPut(() => HomeController());
                      HomeController homeController = Get.put(HomeController());
                      bool success = await loginController.signInEmailAndPassword();
                      homeController.loadUserData();

                      if (success) {
                        Get.to(() => const HomeScreen());
                      } else {
                        Get.dialog(const SuccessDialogWidget(
                          title: 'Амжилтгүй\n Имейл эсвэл нууц үгээ шалгаад дахин оролдоно уу',
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Нэвтрэх', style: TextStyle(fontSize: 15)),
                  ),
                ),
              ),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Text('эсвэл', style: TextStyle(fontSize: 15, color: Colors.black12)),
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
                        'Gmail-ээр нэвтрэх',
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
                        'Facebook-ээр нэвтрэх',
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: SizedBox(
              //     width: 350,
              //     height: 45,
              //     child: ElevatedButton.icon(
              //       onPressed: () {},
              //       icon: Image.asset(
              //         'assets/icons/Apple.png',
              //         height: 20,
              //       ),
              //       label: const Text(
              //         'Sign up with Apple',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //           foregroundColor: Colors.white,
              //           backgroundColor: Colors.white,
              //           side: const BorderSide(color: Colors.black12, width: 1.0),
              //           elevation: 0.0,
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Бүртгэлгүй юу?'),
                    TextButton(
                        onPressed: () {
                          Get.to(const SignUpScreen());
                        },
                        child: const Text(
                          'Бүртгүүлэх',
                          style: TextStyle(color: AppColors.primary700),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

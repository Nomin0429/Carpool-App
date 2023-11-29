import 'dart:developer';

import 'package:carpool_app/components/go_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../style/AppColors.dart';
import '../../components/form_field_item.dart';
import '../component/auto_close_dialog.dart';
import '../logic/signup_controller.dart';

///todo: Registration amjilttai bolson dialog haruulah
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const GoBackButton(),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Доорх хэсгүүдийг бөглөн бүртгүүлээрэй',
                  style: TextStyle(fontSize: 27),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormFieldItem(
                      hintText: 'Нэр',
                      height: 70,
                      width: 360,
                      controller: signUpController.name,
                      icon: const Icon(LineAwesomeIcons.user),
                    ),
                    FormFieldItem(
                      hintText: 'Имейл',
                      height: 70,
                      width: 360,
                      controller: signUpController.email,
                      icon: const Icon(LineAwesomeIcons.envelope),
                    ),
                    FormFieldItem(
                      hintText: 'Утасны дугаар',
                      height: 70,
                      width: 360,
                      controller: signUpController.phoneNo,
                      icon: const Icon(LineAwesomeIcons.phone),
                    ),
                    FormFieldItem(
                      hintText: 'Нууц үг',
                      height: 70,
                      width: 360,
                      controller: signUpController.password,
                      icon: const Icon(LineAwesomeIcons.fingerprint),
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   height: 70,
              //   width: 360,
              //   child: DropdownButtonFormField<String>(
              //     decoration: InputDecoration(
              //         contentPadding: const EdgeInsets.all(18),
              //         hintText: 'Gender',
              //         hintStyle: const TextStyle(color: Colors.grey),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: const BorderSide(width: 1, color: Colors.black12),
              //           borderRadius: BorderRadius.circular(8.0),
              //         )),
              //     onChanged: (String? newValue) {
              //       state.userGender = newValue!;
              //     },
              //     items: <String>['Female', 'Male'].map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 340,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (signUpController.isValidEmail(signUpController.email.text.trim())) {
                        if (formKey.currentState!.validate()) {
                          bool success = await SignUpController.instance.registerEmailAndPassword(
                            signUpController.email.text.trim(),
                            signUpController.password.text.trim(),
                            signUpController.name.text.trim(),
                            signUpController.phoneNo.text.trim(),
                          );

                          if (success) {
                            Get.dialog(const AutoCloseDialog(
                              title: 'Таны бүртгэл амжилттай үүслээ.',
                            ));
                          } else {
                            log('email: ${signUpController.email.text.trim()}');
                            Get.dialog(const AutoCloseDialog(
                              title: 'Амжилтгүй, та дахин оролдоно уу.',
                            ));
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary700),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))),
                    child: const Text('Бүртгүүлэх', style: TextStyle(fontSize: 15)),
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
                        'Gmail-ээр бүртгүүлэх',
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
                        'Facebook-ээр бүртгүүлэх',
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
            ],
          ),
        ),
      ),
    );
  }
}

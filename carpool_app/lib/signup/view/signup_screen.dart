import 'dart:developer';

import 'package:carpool_app/home/view/components/go_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../style/AppColors.dart';
import '../../home/view/components/form_field_item.dart';
import '../component/auto_close_dialog.dart';
import '../logic/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();
  bool isFormFilled = false;
  bool showErrorText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const GoBackButton(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Доорх хэсгүүдийг бөглөн бүртгүүлээрэй',
                  style: TextStyle(fontSize: 27, fontFamily: 'Poppins'),
                ),
              ),
              showErrorText
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Бүх талбарыг бөглөх шаардлагатай',
                        style: TextStyle(color: AppColors.error900, fontFamily: 'Poppins'),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                onChanged: () {
                  setState(() {
                    isFormFilled = formKey.currentState?.validate() ?? false;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormFieldItem(
                      hintText: 'Нэр${isFormFilled ? '' : ' *'}',
                      height: 70,
                      width: 360,
                      controller: signUpController.name,
                      icon: const Icon(LineAwesomeIcons.user),
                    ),
                    FormFieldItem(
                      hintText: 'Имейл${isFormFilled ? '' : ' *'}',
                      height: 70,
                      width: 360,
                      controller: signUpController.email,
                      icon: const Icon(LineAwesomeIcons.envelope),
                    ),
                    FormFieldItem(
                      hintText: 'Утасны дугаар${isFormFilled ? '' : ' *'}',
                      height: 70,
                      width: 360,
                      controller: signUpController.phoneNo,
                      icon: const Icon(LineAwesomeIcons.phone),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          if (showErrorText && value == null) {
                            return 'Утасны дугаараа оруулна уу';
                          }
                          return null;
                        } else if (!signUpController.isValidPhoneNumber(value)) {
                          return 'Утасны дугаар буруу байна';
                        }
                        return null;
                      },
                    ),
                    FormFieldItem(
                      hintText: 'Нууц үг${isFormFilled ? '' : ' *'}',
                      height: 70,
                      width: 360,
                      controller: signUpController.password,
                      icon: const Icon(LineAwesomeIcons.fingerprint),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 340,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        showErrorText = !isFormFilled;
                      });

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
                              title: 'Амжилттай',
                              content: 'Таны бүртгэл амжилттай үүслээ.',
                            ));
                          } else {
                            log('email: ${signUpController.email.text.trim()}');
                            Get.dialog(const AutoCloseDialog(
                              title: 'Амжилтгүй',
                              content: 'Амжилтгүй, та дахин оролдоно уу.',
                            ));
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary700),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                    child: const Text('Бүртгүүлэх', style: TextStyle(fontSize: 15, fontFamily: 'Poppins')),
                  ),
                ),
              ),
              // Other widgets...
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../components/alert_dialog.dart';
import '../../../../style/AppColors.dart';

class UpdateProfileScreen extends GetWidget<HomeController> {
  UpdateProfileScreen({super.key});
  final HomeController _homeController = Get.put(HomeController());

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    Timestamp joinedAtTimestamp = _homeController.homeState.userData['joinedAt'];
    String formattedDate = formatTimestamp(joinedAtTimestamp);

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Бүртгэл засах',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage('assets/images/user_profile.png'),
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.primary300),
                    child: const Icon(
                      LineAwesomeIcons.retro_camera,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 50,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        label: const Text('Нэр'),
                        hintText: _homeController.homeState.userData['name'],
                        prefixIcon: const Icon(LineAwesomeIcons.user),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        label: const Text('Имейл'),
                        hintText: _homeController.homeState.userData['email'],
                        prefixIcon: const Icon(LineAwesomeIcons.envelope),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        label: const Text('Утасны дугаар'),
                        hintText: _homeController.homeState.userData['phone'],
                        prefixIcon: const Icon(LineAwesomeIcons.phone),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        label: const Text('Нууц үг'),
                        hintText: _homeController.homeState.userData['password'],
                        prefixIcon: const Icon(LineAwesomeIcons.fingerprint),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _homeController.homeState.obscureText.value ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            _homeController.homeState.obscureText.value = !_homeController.homeState.obscureText.value;
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () {
                          _homeController.updateUserProfile(nameController.text, emailController.text, phoneController.text, passwordController.text);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary300,
                          shape: const StadiumBorder(),
                          side: BorderSide.none,
                        ),
                        child: const Text(
                          'Болсон',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(TextSpan(text: formattedDate, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), children: const [
                        TextSpan(
                          text: '-нд бүртгүүлсэн',
                          style: TextStyle(fontSize: 12),
                        )
                      ])),
                      ElevatedButton(
                          onPressed: () {
                            Get.dialog(
                              ShowAlertDialog(
                                onTap: () {
                                  _homeController.deleteUserAccount();
                                },
                                title: 'Бүртгэл устгах',
                                onTapText: 'Устгах',
                                subtitle: 'Та бүртгэлээ устгахдаа итгэлтэй байна уу?',
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error50,
                            elevation: 0.0,
                            foregroundColor: AppColors.error500,
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                          ),
                          child: const Text('Бүртгэл устгах'))
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

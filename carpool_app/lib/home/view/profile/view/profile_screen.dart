import 'package:carpool_app/home/view/components/go_back_button.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/profile/components/profile_menu_item.dart';
import 'package:carpool_app/home/view/profile/view/car_profile.dart';
import 'package:carpool_app/home/view/profile/view/wallet/my_wallet_screen.dart';
import 'package:carpool_app/home/view/profile/view/ride_history_screen.dart';
import 'package:carpool_app/home/view/profile/view/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../components/alert_dialog.dart';
import '../../../../style/AppColors.dart';

class ProfileScreen extends GetWidget<HomeController> {
  ProfileScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    const GoBackButton(),
                    const SizedBox(
                      width: 230,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(CarProfile());
                      },
                      icon: const Icon(LineAwesomeIcons.car),
                      style: IconButton.styleFrom(
                          shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: AppColors.primary500))),
                    )
                  ],
                ),
                Column(
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
                            LineAwesomeIcons.alternate_pencil,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Text(
                    _homeController.homeState.userData['name'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Obx(
                  () => Text(
                    _homeController.homeState.userData['email'],
                    style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => UpdateProfileScreen(),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary800, side: BorderSide.none, shape: const StadiumBorder()),
                    child: const Text(
                      'Бүртгэл засах',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),

                ///menu
                ProfileMenuItem(
                  title: 'Аяллын түүх',
                  icon: LineAwesomeIcons.history,
                  onTap: () {
                    Get.to(const RideHistoryScreen());
                  },
                ),
                ProfileMenuItem(
                  title: 'Миний хэтэвч',
                  icon: LineAwesomeIcons.wallet,
                  onTap: () {
                    Get.to(MyWallet());
                  },
                ),
                ProfileMenuItem(
                  title: 'Бидний тухай',
                  icon: LineAwesomeIcons.info,
                  onTap: () {
                    null;
                  },
                ),
                ProfileMenuItem(
                  title: 'Тохиргоо',
                  icon: LineAwesomeIcons.cog,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  title: 'Тусламж',
                  icon: LineAwesomeIcons.question_circle,
                  onTap: () {},
                ),
                ProfileMenuItem(
                  title: 'Системээс гарах',
                  icon: LineAwesomeIcons.alternate_sign_out,
                  onTap: () {
                    Get.dialog(
                      ShowAlertDialog(
                        onTap: () {
                          _homeController.signOut();
                        },
                        title: 'Системээс гарах',
                        onTapText: 'Гарах',
                        subtitle: 'Та системээс гарахдаа итгэлтэй байна уу?',
                        isCar: false,
                      ),
                    );
                  },
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

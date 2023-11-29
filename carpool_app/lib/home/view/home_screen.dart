import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpool_app/components/alert_dialog.dart';
import 'package:carpool_app/home/component/home_app_bar.dart';
import 'package:carpool_app/home/component/option_card.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/home_screen_driver.dart';
import 'package:carpool_app/home/view/home_screen_rider.dart';
import 'package:carpool_app/home/view/profile/view/car_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final greeting = homeController.getGreeting();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const HomeAppBar(isHome: true),
                const SizedBox(
                  height: 35,
                ),
                Obx(
                  () => Text(
                    '$greeting, \n ${homeController.homeState.userData['name']}',
                    style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 35),
                OptionCard(
                    title: 'Жолоодох гэж байна уу?',
                    description: 'Хэдэн хүн аваад, хаанаас хаашаа явахаа,замдаа хаана хаана зогсохоо, хэзээ явахаа оруулснаар таны аялал үүснэ.',
                    isDriver: true,
                    cardHeight: 180.0,
                    onTap: () {
                      homeController.homeState.userData['cars'].isEmpty
                          ? Get.dialog(ShowAlertDialog(
                              onTap: () {
                                Get.to(CarProfile());
                              },
                              title: 'Машин нэмэх',
                              onTapText: 'Машин нэмэх',
                              subtitle: 'Та аялал үүсгэхийн тулд машинтай байх ёстой. Та машингүй байгаа тул машин нэмэх үү?'))
                          : Get.to(HomeScreenDriver());
                    }),
                const SizedBox(
                  height: 10,
                ),
                OptionCard(
                  title: 'Дайгдах гэж байна уу?',
                  description: 'Нэг зүгт явах унаагаа олоод тухтай зорчоорой.',
                  isDriver: false,
                  cardHeight: 180.0,
                  onTap: () {
                    homeController.listenToRides();
                    Get.to(HomeScreenRider());
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CachedNetworkImage(
                    imageUrl: homeController.homeState.weatherIcon.value,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Text(
                    '${homeController.homeState.weatherTemp.value}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

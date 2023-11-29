import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../style/AppColors.dart';
import '../components/add_car_dialog.dart';
import '../components/my_cars_item.dart';

class CarProfile extends GetWidget<HomeController> {
  CarProfile({super.key});
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Миний машинууд', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          shape: const CircleBorder(
                            side: BorderSide(color: AppColors.primary700),
                          )),
                      onPressed: () {
                        Get.dialog(AddCarDialog());
                      },
                      child: const Icon(
                        LineAwesomeIcons.plus,
                        color: AppColors.primary700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _homeController.homeState.userData['cars']?.isNotEmpty == true
                ? MyCarsItem(cars: (_homeController.homeState.userData['cars'] as List).map((item) => Map<String, String>.from(item)).toList())
                : const Center(child: Text('Танд машин байхгүй байна')),
          ],
        ),
      ),
    );
  }
}

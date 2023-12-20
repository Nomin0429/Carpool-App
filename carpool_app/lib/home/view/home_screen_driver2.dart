import 'package:carpool_app/home/view/components/go_back_button.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/profile/view/ride_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../style/AppColors.dart';
import 'components/ride_dialog.dart';
import 'components/time_input_getter.dart';
import 'home_screen.dart';

class HomeScreenDriver2 extends GetWidget<HomeController> {
  HomeScreenDriver2({super.key});

  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const GoBackButton(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Бидний санал болгож буй үнэ:',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 40,
              ),

              SizedBox(
                width: 250,
                child: Obx(
                  () => Text(
                    '${_homeController.homeState.pricePerKm.value}₮/км',
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
                  ),
                  //],
                ),
              ),
              //),
              Container(
                height: 1,
                width: 300,
                decoration: const BoxDecoration(color: Colors.black),
              ),

              ///Editable price per km
              // SizedBox(
              //   width: 200, // Take the full width available
              //   child: Obx(
              //     () => Row(
              //       children: [
              //         Expanded(
              //           child: TextFormField(
              //             controller: TextEditingController(text: _homeController.homeState.pricePerKm.value.toString()),
              //             onChanged: (value) {
              //               final parsedValue = double.tryParse(value);
              //               if (parsedValue != null) {
              //                 _homeController.homeState.pricePerKm.value = parsedValue as int;
              //               }
              //             },
              //             keyboardType: const TextInputType.numberWithOptions(decimal: true),
              //             // Add other properties as needed
              //           ),
              //         ),
              //         const Text('₮/км', style: TextStyle(fontSize: 20)),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 340,
              ),
              SizedBox(
                width: 320,
                height: 54,
                child: ElevatedButton(
                    onPressed: () async {
                      DateTime finalDateTime =
                          combineDateTime((_homeController.selectedTime ?? DateTime.now()) as TimeOfDay?, _homeController.dayController.text);

                      bool success = await _homeController.createRide(
                        _homeController.destinationController.text,
                        _homeController.originController.text,
                        _homeController.possibleStopsController.text.split(',').map((e) => e.trim()).toList(),
                        _homeController.dayController.text,
                        finalDateTime,
                        _homeController.carController.text,
                        int.tryParse(_homeController.seatsAvailableController.text) ?? 1,
                        _homeController.homeState.pricePerKm.value,
                      );
                      if (success) {
                        Get.dialog(
                          RideDialog(
                            onConfirm: () {
                              Get.back();
                              Get.back();
                              Get.off(() => const RideHistoryScreen());
                            },
                            title: 'Амжилттай',
                            contentText: 'Таны аялал амжилттай үүслээ. Та аялалын түүх хэсгээс өөрийн аяллыг харах боломжтой',
                            cancelButtonText: 'За',
                            onCancel: () {
                              Get.back();
                              Get.back();
                              Get.off(() => const HomeScreen());
                            },
                            confirmButtonText: 'Аяллаа харах',
                            color: AppColors.primary550,
                          ),
                        );
                      } else {
                        Get.dialog(
                          RideDialog(
                            onConfirm: () {
                              Get.back();
                            },
                            title: 'Амжилтгүй',
                            contentText: 'Та дахин оролдоно уу',
                            cancelButtonText: 'Үгүй',
                            onCancel: () {
                              Get.back();
                              Get.back();
                              Get.off(() => const HomeScreen());
                            },
                            confirmButtonText: 'Дахин оролдох',
                            color: AppColors.primary550,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary550, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    child: const Text(
                      'Аялал үүсгэх',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'package:carpool_app/components/go_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../components/form_field_item.dart';
import '../../style/AppColors.dart';
import '../logic/home_controller.dart';
import 'home_screen_driver2.dart';

class HomeScreenDriver extends GetWidget<HomeController> {
  HomeScreenDriver({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final userData = _homeController.homeState.userData;
    final List<dynamic> cars = (userData['cars'] ?? []) as List<dynamic>;
    final List<String> serialNumbers = List<String>.from(cars.map((car) => car['serialNo'] ?? ''));
    if (serialNumbers.isNotEmpty) {
      _homeController.homeState.carSerialNo.value = serialNumbers.first;
      _homeController.carController.text = _homeController.homeState.carSerialNo.value;
    }
    if (_homeController.dayController.text.isEmpty) {
      _homeController.dayController.text = 'Өнөөдөр';
    }
    var dayText = 'Өнөөдөр'.obs;

    bool isValidTime(String? value) {
      if (value == null || value.isEmpty) return false;
      final parts = value.split(':');
      if (parts.length != 2) return false;
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour == null || minute == null) return false;
      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return false;
      return true;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const GoBackButton(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Аялал үүсгэхэд шаардлагатай мэдээллийг оруулна уу',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 40,
                ),
                FormFieldItem(
                  controller: _homeController.originController,
                  hintText: 'Хаанаас хөдлөх',
                  height: 70,
                  width: 340,
                  icon: const Icon(LineAwesomeIcons.bullseye),
                  borderColor: AppColors.primary550,
                  borderRadius: 20,
                  onChanged: (value) {
                    _homeController.checkIfAllFieldsFilled();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormFieldItem(
                  controller: _homeController.destinationController,
                  hintText: 'Хаашаа очих',
                  height: 70,
                  width: 340,
                  icon: const Icon(LineAwesomeIcons.map_marker),
                  borderColor: AppColors.primary550,
                  borderRadius: 20,
                  onChanged: (value) {
                    _homeController.checkIfAllFieldsFilled();
                  },
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Text(
                    'Та боломжит зогсоолууд хэсэгт өөрийн явах замаа тодорхой болгох үүднээс хэдэн зогсоолыг оруулж өгнө үү.',
                    style: TextStyle(fontSize: 10, color: Colors.black26.withOpacity(0.4)),
                  ),
                ),
                FormFieldItem(
                  controller: _homeController.possibleStopsController,
                  hintText: 'Боломжит зогсоолууд',
                  height: 70,
                  width: 340,
                  icon: const Icon(LineAwesomeIcons.parking),
                  borderColor: AppColors.primary550,
                  borderRadius: 20,
                  onChanged: (value) {
                    _homeController.checkIfAllFieldsFilled();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primary550),
                        ),
                        child: Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dayText.value,
                              onChanged: (newValue) {
                                dayText.value = newValue!;
                                _homeController.dayController.text = newValue;

                                log('Selected value: $newValue');
                                _homeController.checkIfAllFieldsFilled();
                              },
                              items: const ['Өнөөдөр', 'Маргааш'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    FormFieldItem(
                      controller: _homeController.timeController,
                      hintText: 'hh:mm',
                      height: 50,
                      width: 150,
                      icon: const Icon(LineAwesomeIcons.clock),
                      borderColor: AppColors.primary550,
                      borderRadius: 20,
                      inputFormat: 'hh:mm',
                      onChanged: (value) {
                        if (!isValidTime(value)) {
                          log('invalidtime');
                        }
                        _homeController.checkIfAllFieldsFilled();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.primary550)),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _homeController.homeState.carSerialNo.value,
                            onChanged: (newValue) {
                              _homeController.homeState.carSerialNo.value = newValue!;
                              _homeController.checkIfAllFieldsFilled();
                            },
                            items: serialNumbers.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(width: 30),
                    FormFieldItem(
                      controller: _homeController.seatsAvailableController,
                      hintText: 'Сул суудал',
                      height: 70,
                      width: 150,
                      icon: const Icon(LineAwesomeIcons.user),
                      borderColor: AppColors.primary550,
                      borderRadius: 20,
                      onChanged: (value) {
                        _homeController.checkIfAllFieldsFilled();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 320,
                  height: 54,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: _homeController.allFieldsFilled.value
                          ? () {
                              Get.to(() => HomeScreenDriver2());
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _homeController.allFieldsFilled.value ? AppColors.error800 : AppColors.error200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Цааш нь'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

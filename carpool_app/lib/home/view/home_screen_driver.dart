import 'dart:developer';
import 'package:carpool_app/home/view/components/go_back_button.dart';
import 'package:carpool_app/home/view/components/time_input_getter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'components/custom_autocomplete.dart';
import 'components/form_field_item.dart';
import '../../style/AppColors.dart';
import '../logic/home_controller.dart';
import 'components/possible_stops_getter.dart';
import 'home_screen_driver2.dart';

class HomeScreenDriver extends GetWidget<HomeController> {
  HomeScreenDriver({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final userData = _homeController.homeState.userData;
    RxBool allFieldsFilled = false.obs;
    void checkIfAllFieldsFilled() {
      allFieldsFilled.value = _homeController.originController.text.isNotEmpty &&
          _homeController.destinationController.text.isNotEmpty &&
          _homeController.possibleStopsController.text.isNotEmpty &&
          _homeController.seatsAvailableController.text.isNotEmpty;
    }

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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomAutoComplete(
                  controller: _homeController.originController,
                  hintText: 'Хөдлөх цэг',
                  icon: const Icon(
                    LineAwesomeIcons.bullseye,
                    color: AppColors.primary300,
                  ),
                  isTextBlack: true,
                  height: 70,
                  width: 340,
                  isOrigin: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomAutoComplete(
                  controller: _homeController.destinationController,
                  hintText: 'Хаашаа очих',
                  height: 70,
                  width: 340,
                  isTextBlack: true,
                  icon: const Icon(
                    LineAwesomeIcons.map_marker,
                    color: AppColors.primary300,
                  ),
                  isOrigin: false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Text(
                    'Таны боломжит зогсоолуудад оруулсан зогсоолуудаас хэрэглэгч өөрийн буух суух цэгийг сонгох тул боломжит бүх зогсоолыг оруулна уу.',
                    style: TextStyle(fontSize: 10, color: Colors.black26.withOpacity(0.4)),
                  ),
                ),
                const PossibleStopsGetter(),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 57,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primary300),
                          ),
                          child: Obx(
                            () => DropdownButtonHideUnderline(
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    LineAwesomeIcons.calendar,
                                    color: AppColors.primary300,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      value: dayText.value,
                                      onChanged: (newValue) {
                                        dayText.value = newValue!;
                                        _homeController.dayController.text = newValue;
                                        log('daycontroller: ${_homeController.dayController.text}');
                                        log('Selected value: $newValue');
                                        checkIfAllFieldsFilled();
                                      },
                                      items: const ['Өнөөдөр', 'Маргааш'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      TimeInputGetter(
                        onTimeSelected: (TimeOfDay selectedTime) {
                          checkIfAllFieldsFilled();
                          _homeController.selectedTime = selectedTime;
                          log("Selected Time: $selectedTime");
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 57,
                          width: 165,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primary300),
                          ),
                          child: Obx(
                            () => DropdownButtonHideUnderline(
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    LineAwesomeIcons.car,
                                    color: AppColors.primary300,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _homeController.homeState.carSerialNo.value,
                                      onChanged: (newValue) {
                                        _homeController.homeState.carSerialNo.value = newValue!;
                                      },
                                      items: serialNumbers.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            // style: const TextStyle(color: AppColors.primary300),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      FormFieldItem(
                        controller: _homeController.seatsAvailableController,
                        hintText: 'Сул суудал',
                        height: 57,
                        width: 160,
                        icon: const Icon(
                          LineAwesomeIcons.user,
                          color: AppColors.primary300,
                        ),
                        borderColor: AppColors.primary300,
                        borderRadius: 20,
                        onChanged: (value) {
                          checkIfAllFieldsFilled();
                          log('seatsAvailableController: ${_homeController.seatsAvailableController.text}');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 320,
                  height: 54,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: allFieldsFilled.value
                          ? () {
                              try {
                                Get.to(() => HomeScreenDriver2());
                              } catch (e) {
                                log('Navigation Error: $e');
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: allFieldsFilled.value ? AppColors.primary550 : AppColors.error100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Text(
                        'Цааш нь',
                        style: TextStyle(
                            fontSize: 15,
                            color: allFieldsFilled.value ? Colors.white : Colors.black,
                            fontWeight: allFieldsFilled.value ? FontWeight.w600 : FontWeight.w300),
                      ),
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

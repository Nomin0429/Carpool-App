import 'dart:developer';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/components/go_back_button.dart';
import 'package:carpool_app/home/view/ride_input_by_rider/rider_input_to_ride.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../style/AppColors.dart';
import '../components/form_field_item.dart';

class RideDetailsRiderToRide extends GetWidget<HomeController> {
  final Map ride;
  RxBool isExpanded = false.obs;
  RxBool isTripExpanded = false.obs;
  RxBool isRiderExpanded = true.obs;

  RideDetailsRiderToRide({super.key, required this.ride});
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const GoBackButton(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary300.withOpacity(0.1),
                  ),
                  child: Obx(
                    () => Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        title: const Text(
                          'Жолоочийн мэдээлэл',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        onExpansionChanged: (bool expanded) {
                          isExpanded.value = expanded;
                        },
                        children: [
                          if (isExpanded.value)
                            Row(
                              children: [
                                SizedBox(height: 110, child: Image.asset('assets/images/user_profile.png')),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 170,
                                      decoration:
                                          BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.black, width: 2)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset('assets/images/soyombo.png'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              ride['car'],
                                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Text(
                                            homeController.homeState.driverData['name'],
                                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            LineAwesomeIcons.star_1,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${homeController.homeState.driverData['avgRating']}',
                                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [const Icon(LineAwesomeIcons.phone), Text(homeController.homeState.driverData['phone'])],
                                    )
                                  ],
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary200.withOpacity(0.1),
                  ),
                  child: Obx(
                    () => Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        title: const Text(
                          'Аяллын мэдээлэл',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        onExpansionChanged: (bool expanded) {
                          isTripExpanded.value = expanded;
                        },
                        children: [
                          if (isTripExpanded.value)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Хөдлөх цаг',
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '${ride['day']},  ${homeController.getHourMinuteFromTimestamp(ride['startTime'])}',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Эхлэх цэг'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${ride['origin']}',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Дуусах цэг'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${ride['destination']}',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Боломжит зогсоолууд'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton<String>(
                                      hint: const Text('Зогсоолууд'),
                                      onChanged: (String? selectedStop) {
                                        log('Selected stop: $selectedStop');
                                      },
                                      items: (ride['possibleStops'] as List<dynamic>).map((stop) {
                                        return DropdownMenuItem<String>(
                                          value: stop.toString(),
                                          child: Text(stop.toString()),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Километрийн үнэ'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${ride['pricePerKm']} км/₮',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Сул суудлын тоо'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${ride['seatsAvailable']}',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary500.withOpacity(0.1),
                  ),
                  child: Obx(
                    () => Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        title: const Text(
                          'Зорчигчийн бөглөх хэсэг',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        onExpansionChanged: (bool expanded) {
                          isRiderExpanded.value = expanded;
                        },
                        children: [
                          if (isRiderExpanded.value)
                            Column(
                              children: [
                                RiderInputToRide(
                                  ride: ride,
                                  hintText: 'Суух цэг',
                                  isOrigin: true,
                                  icon: const Icon(LineAwesomeIcons.bullseye),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                RiderInputToRide(
                                  ride: ride,
                                  hintText: 'Буух цэг',
                                  isOrigin: false,
                                  icon: const Icon(LineAwesomeIcons.map_marker),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Танд захиалах боломжтой \n',
                                          style: const TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.grey),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '${ride['seatsAvailable']}',
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                                            const TextSpan(
                                              text: ' суудал байна.',
                                              style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Align(
                                        alignment: Alignment.centerRight,
                                        child: FormFieldItem(
                                          hintText: 'Суудлын тоо',
                                          height: 70,
                                          icon: Icon(LineAwesomeIcons.user),
                                          width: 160,
                                          borderColor: Colors.grey,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                      child: const Text(
                                        'Болих',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary500,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                        child: const Text(
                                          'Төлбөр төлөх',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                        )),
                                  ],
                                )
                              ],
                            )
                        ],
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

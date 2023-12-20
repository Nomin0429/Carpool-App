import 'dart:developer';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/components/go_back_button.dart';
import 'package:carpool_app/home/view/ride_input_by_rider/rider_input_to_ride.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../style/AppColors.dart';
import '../components/driver_details_item.dart';
import '../components/form_field_item.dart';
import '../components/ride_details_item.dart';
import '../payment/payment_dialog.dart';

class RideDetailsRiderToRide extends GetWidget<HomeController> {
  final Map ride;
  final String rideId;
  const RideDetailsRiderToRide({
    super.key,
    required this.ride,
    required this.rideId,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isExpanded = false.obs;
    RxBool isTripExpanded = false.obs;
    final riderOriginController = TextEditingController();
    final riderDestinationController = TextEditingController();
    final bookedSeatsController = TextEditingController();
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
                    borderRadius: BorderRadius.circular(10),
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
                            DriverDetailsItem(
                              ride: ride,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary700,
                    borderRadius: BorderRadius.circular(10),
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
                            RideDetailsItem(
                              ride: ride,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Зорчигчийн бөглөх хэсэг',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 340,
                          child: RiderInputToRide(
                            ride: ride,
                            hintText: 'Суух цэг',
                            isOrigin: true,
                            icon: const Icon(
                              LineAwesomeIcons.bullseye,
                              color: AppColors.primary900,
                            ),
                            textController: riderOriginController,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 340,
                          child: RiderInputToRide(
                            ride: ride,
                            hintText: 'Буух цэг',
                            isOrigin: false,
                            icon: const Icon(
                              LineAwesomeIcons.map_marker,
                              color: AppColors.primary900,
                            ),
                            textController: riderDestinationController,
                          ),
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
                            Align(
                                alignment: Alignment.centerRight,
                                child: FormFieldItem(
                                  controller: bookedSeatsController,
                                  hintText: 'Суудлын тоо',
                                  height: 70,
                                  icon: const Icon(LineAwesomeIcons.user),
                                  width: 160,
                                  borderColor: AppColors.primary700,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary700, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              onPressed: () async {
                                try {
                                  final int bookedSeats = int.parse(bookedSeatsController.text);
                                  await controller.getDistanceFromBackend(riderOriginController.text, riderDestinationController.text, bookedSeats);
                                  log('rider input: ${riderOriginController.text} , ${riderDestinationController.text}, $bookedSeats');
                                  Get.dialog(PaymentDialog(
                                    rideID: rideId,
                                    origin: riderOriginController.text,
                                    destination: riderDestinationController.text,
                                    bookedSeats: bookedSeats,
                                  ));
                                } catch (e) {
                                  log('Error converting booked seats to integer: $e');
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                                child: Text(
                                  'Төлбөр төлөх',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

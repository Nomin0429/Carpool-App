import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/components/ride_details_item.dart';
import 'package:carpool_app/home/view/ride_history/rider_item_in_driver_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../style/AppColors.dart';

class RideHistoryDriver extends GetWidget<HomeController> {
  final Map currentRide;
  final List riders;

  const RideHistoryDriver({
    super.key,
    required this.currentRide,
    required this.riders,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineAwesomeIcons.arrow_left)),
        title: const Text('Аяллын дэлгэрэнгүй'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: AppColors.primary700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RideDetailsItem(ride: currentRide)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Зорчигчид',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: currentRide['riders'].length,
              itemBuilder: (context, index) {
                String riderId = currentRide['riders'].keys.elementAt(index);
                controller.getUserDataByUserId(riderId);
                Map riderDetails = currentRide['riders'][riderId];
                return RiderItemInDriverHistory(
                  rider: riderDetails,
                  riderUserId: riderId,
                  isRideStarted: false,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary800),
              child: const Text('Аялал эхлэх'),
            ),
          ],
        ),
      ),
    );
  }
}

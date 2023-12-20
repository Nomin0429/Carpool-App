import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/components/ride_details_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RideDetailsItem(ride: currentRide),
          const Text('Зорчигчид'),
        ],
      ),
    );
  }
}

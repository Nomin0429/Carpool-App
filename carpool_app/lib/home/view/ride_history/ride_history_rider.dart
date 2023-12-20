import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/components/driver_details_item.dart';
import 'package:carpool_app/home/view/components/ride_details_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../style/AppColors.dart';

class RideHistoryRider extends GetWidget<HomeController> {
  final Map currentRide;
  final List<Map> myRide;

  const RideHistoryRider({
    super.key,
    required this.myRide,
    required this.currentRide,
  });

  @override
  Widget build(BuildContext context) {
    Map myDetails = myRide.isNotEmpty ? myRide[0] : {};

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LineAwesomeIcons.arrow_left),
        ),
        title: const Text(
          'Аяллын дэлгэрэнгүй',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DriverDetailsItem(ride: currentRide),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RideDetailsItem(ride: currentRide)),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Таны мэдээлэл',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      LineAwesomeIcons.bullseye,
                      color: AppColors.primary300,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(myDetails['origin'].split(',')[0] ?? '', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 10),
                    const Icon(
                      LineAwesomeIcons.arrow_down,
                      color: AppColors.primary300,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      LineAwesomeIcons.map_marker,
                      color: AppColors.primary300,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      myDetails['destination'].split(',')[0] ?? '',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(LineAwesomeIcons.user, color: AppColors.primary300),
                    const SizedBox(
                      width: 7,
                    ),
                    Text('${myDetails['bookedSeats']} суудал захиалсан.' ?? '', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: Text(
                            'Цуцлах',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: Text(
                            'Суусан',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
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

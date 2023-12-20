import 'dart:developer';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/ride_input_by_rider/ride_details_rider_to_ride.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'components/ride_list_item.dart';

class HomeScreenRider extends GetWidget<HomeController> {
  HomeScreenRider({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 1,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: const Text('Бүх унаанууд'),
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
                  pinned: true,
                  // Remove the TabBar
                ),
              ];
            },
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _homeController.homeState.openRides.length,
                        itemBuilder: (context, index) {
                          final rideId = _homeController.homeState.openRides.keys.elementAt(index);
                          final ride = _homeController.homeState.openRides[rideId];
                          final currentUserId = _homeController.getUserId();
                          if (ride['driverId'] != currentUserId) {
                            return RideListItem(
                              ride: ride,
                              textButton: 'Дайгдая',
                              onTapTextButton: () async {
                                log('nomioo ride: $ride');
                                await _homeController.updateDriverData(ride);
                                Get.to(RideDetailsRiderToRide(ride: ride, rideId: rideId));
                              },
                            );
                          }
                          return null;
                        },
                      );
                    }),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

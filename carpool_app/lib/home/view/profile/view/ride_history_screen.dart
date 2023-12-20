import 'dart:developer';

import 'package:carpool_app/home/view/ride_history/ride_history_driver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/components/ride_list_item.dart';
import 'package:carpool_app/home/view/ride_history/ride_history_rider.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  _RideHistoryScreenState createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserId = homeController.getUserId();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Аяллын түүх'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'Удахгүй эхлэх'),
            Tab(text: 'Эхэлсэн'),
            Tab(text: 'Дууссан'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          RideList(currentUserId: currentUserId, rideType: 'open'),
          RideList(currentUserId: currentUserId, rideType: 'started'),
          RideList(currentUserId: currentUserId, rideType: 'done'),
        ],
      ),
    );
  }
}

class RideList extends StatelessWidget {
  final String currentUserId;
  final String rideType;
  final HomeController homeController = Get.find();

  RideList({Key? key, required this.currentUserId, required this.rideType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rideWidgets = [];
    List<Map> userRides = [];
    List<Map> otherRides = [];
    List<Map> myDetails = [];

    List<Map<dynamic, dynamic>> rideList = (rideType == 'open'
            ? homeController.homeState.openRides
            : rideType == 'started'
                ? homeController.homeState.startedRides
                : homeController.homeState.doneRides)
        .values
        .map((value) => value as Map<dynamic, dynamic>)
        .toList();

    for (final ride in rideList) {
      if (ride['driverId'] == currentUserId) {
        userRides.add(ride);
      } else if (ride['riders'].containsKey(currentUserId)) {
        otherRides.add(ride);
        Map currentUserDetails = ride['riders'][currentUserId] as Map;
        myDetails.add(currentUserDetails);
      }
    }

    if (userRides.isNotEmpty) {
      rideWidgets.add(const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Таны үүсгэсэн',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ));

      for (final ride in userRides) {
        rideWidgets.add(RideListItem(
          ride: ride,
          textButton: 'Харах',
          onTapTextButton: () {
            log('Ride data: $ride');
            Get.to(RideHistoryDriver(
              currentRide: ride,
              riders: [ride['riders']],
            ));
          },
        ));
      }
    } else {
      rideWidgets.add(const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Танд үүсгэсэн унаа байхгүй байна.'),
      ));
    }

    if (otherRides.isNotEmpty) {
      rideWidgets.add(const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Таны дайгдах',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ));

      for (final ride in otherRides) {
        rideWidgets.add(RideListItem(
          ride: ride,
          textButton: 'Харах',
          onTapTextButton: () async {
            await homeController.updateDriverData(ride);
            Get.to(RideHistoryRider(myRide: myDetails, currentRide: ride));
          },
        ));
      }
    } else {
      rideWidgets.add(const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Танд дайгдсан унаа байхгүй байна.'),
      ));
    }

    return ListView(
      children: rideWidgets,
    );
  }
}

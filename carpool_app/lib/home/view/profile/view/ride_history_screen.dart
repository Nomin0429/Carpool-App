import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/ride_list_item.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  _RideHistoryScreenState createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserId = homeController.getUserId();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Аяллын түүх'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Удахгүй эхлэх'),
            Tab(text: 'Эхэлсэн'),
            Tab(text: 'Дууссан'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RideList(
            rides: homeController.homeState.openRides,
            currentUserId: currentUserId,
          ),
          RideList(
            rides: homeController.homeState.startedRides,
            currentUserId: currentUserId,
          ),
          RideList(
            rides: homeController.homeState.doneRides,
            currentUserId: currentUserId,
          ),
        ],
      ),
    );
  }
}

class RideList extends StatelessWidget {
  final RxMap<String, dynamic> rides;
  final String currentUserId;

  const RideList({Key? key, required this.rides, required this.currentUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> rideWidgets = [];
    final List<Map> userRides = [];
    final List<Map> otherRides = [];

    final List<Map<dynamic, dynamic>> rideList = rides.values.map((value) => value as Map<dynamic, dynamic>).toList();

    for (final ride in rideList) {
      if (ride['driverId'] == currentUserId) {
        userRides.add(ride);
      } else if (ride['riders'].containsKey(currentUserId)) {
        otherRides.add(ride);
      }
    }

    // hereglegchiin uusgesn ride-uud
    if (userRides.isNotEmpty) {
      rideWidgets.add(
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Таны үүсгэсэн',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );

      for (final ride in userRides) {
        rideWidgets.add(
          RideListItem(
            ride: ride,
            textButton: 'Харах',
            onTapTextButton: () {},
          ),
        );
      }
    }

    // Newtersn hereglegch rider bh unaanud
    if (otherRides.isNotEmpty) {
      rideWidgets.add(
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Таны дайгдсан',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );

      for (final ride in otherRides) {
        rideWidgets.add(
          RideListItem(
            ride: ride,
            textButton: 'Дэлгэрэнгүй',
            onTapTextButton: () {},
          ),
        );
      }
    }

    return ListView(
      children: rideWidgets,
    );
  }
}

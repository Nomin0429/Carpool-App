import 'package:carpool_app/components/form_field_item.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/home_screen.dart';
import 'package:carpool_app/style/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../component/ride_list_item.dart';

class HomeScreenRider extends GetWidget<HomeController> {
  HomeScreenRider({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
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
                    bottom: const TabBar(
                      indicatorColor: AppColors.primary300,
                      labelColor: AppColors.primary300,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 16),
                      unselectedLabelStyle: TextStyle(fontSize: 16),
                      tabs: [
                        Tab(text: 'Бүх унаанууд'),
                        Tab(text: 'Хайх'),
                      ],
                    ),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Бүх унаанууд',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _homeController.homeState.rides.length,
                          itemBuilder: (context, index) {
                            final rideId = _homeController.homeState.rides.keys.elementAt(index);
                            final ride = _homeController.homeState.rides[rideId];

                            DateTime startTime = (ride['time'] as Timestamp).toDate();
                            String formattedTime = DateFormat('HH:mm').format(startTime);

                            return RideListItem(
                              carSerialNo: ride['car'],
                              seatsAvailable: ride['seatsAvailable'],
                              origin: ride['origin'],
                              destination: ride['destination'],
                              pricePerKm: ride['price'].toDouble(),
                              startTime: formattedTime,
                            );
                          },
                        );
                      }),
                    ]),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Аялал хайхад шаардлагатай мэдээллийг оруулна уу.',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const FormFieldItem(
                          hintText: 'Хаанаас хөдлөх',
                          height: 70,
                          width: 340,
                          icon: Icon(LineAwesomeIcons.bullseye),
                          borderRadius: 20,
                          borderColor: AppColors.primary300,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 320,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const HomeScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error800,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Хайх'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

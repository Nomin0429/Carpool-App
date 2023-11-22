import 'package:carpool_app/home/component/home_app_bar.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenDriver extends GetWidget<HomeController> {
  HomeScreenDriver({Key? key}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeAppBar(isHome: false),
            ],
          ),
        ),
      )),
    );
  }
}

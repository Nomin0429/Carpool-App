import 'package:carpool_app/home/component/home_app_bar.dart';
import 'package:carpool_app/home/component/option_card.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/home_screen_driver.dart';
import 'package:carpool_app/home/view/home_screen_rider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final greeting = homeController.getGreeting();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const HomeAppBar(isHome: true),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  '$greeting, \nНомин.',
                  style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 35),
                OptionCard(
                    title: 'Жолоодох гэж байна уу?',
                    description: 'Хэдэн хүн аваад, хаанаас хаашаа явахаа,замдаа хаана хаана зогсохоо, хэзээ явахаа оруулснаар таны аялал үүснэ.',
                    isDriver: true,
                    cardHeight: 180.0,
                    onTap: () {
                      Get.to(HomeScreenDriver());
                    }),
                const SizedBox(
                  height: 10,
                ),
                OptionCard(
                  title: 'Дайгдах гэж байна уу?',
                  description: 'Хэдүүлээ, хаанаас хаашаа явахаа, хэзээ явахаа оруулан дайгдах унаануудаа олон сонгоод яваарай.',
                  isDriver: false,
                  cardHeight: 180.0,
                  onTap: () {
                    Get.to(HomeScreenRider());
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                // !_homeController.homeState.isLoadingWeather.value
                //     ? Row(children: [
                //         //Image.network(_homeController.homeState.weatherIcon.value),
                //         //Image.network('${_homeController.homeState.weatherData['iconUrl'].value}'),
                //         //Text('${_homeController.homeState.weatherData['temp_c']}')
                //       ])
                //     : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

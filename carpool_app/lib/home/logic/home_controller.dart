import 'dart:developer';
import 'package:carpool_app/home/state/home_state.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeState homeState = HomeState();

  @override
  Future<void> onInit() async {
    super.onInit();
    getGreeting();
    // await getLocation().then((value) {
    //   log('value');
    // });
    await getWeatherData(homeState.lat.value, homeState.lon.value);
    log('longitude : ${homeState.lon.value}');
  }

  ///Цагаас хамааран мэндчилгээний үг буцаах функц
  String getGreeting() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour >= 5 && hour < 12) {
      return 'Өглөөний мэнд';
    } else if (hour >= 12 && hour < 17) {
      return 'Өдрийн мэнд';
    } else {
      return 'Оройн мэнд';
    }
  }

  /// Цаг агаарын температур, icon авах функц
  Future<void> getWeatherData(double lat, double lon) async {
    const apiKey = '0fa7d5eb35dd4b14ac531815230908';
    String baseUrl = 'http://api.weatherapi.com/v1';
    final apiUrl = '$baseUrl/current.json?key=$apiKey&q=$lat,$lon';

    homeState.isLoadingWeather.value = false;
    final dio = Dio();
    final response = await dio.get(apiUrl);
    if (response.statusCode == 200) {
      homeState.weatherIcon.value = 'http:${response.data['current']['condition']['icon']}';
    } else {
      log('Амжилтгүй');
    }

    log('nomiooo icon url ${homeState.weatherIcon.value}');
    homeState.isLoadingWeather.value = true;
  }
}

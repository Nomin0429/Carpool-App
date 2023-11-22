import 'package:get/get.dart';

class HomeState {
  RxMap<String, dynamic> userData = RxMap();
  RxString weatherIcon = ''.obs;
  RxDouble lat = 47.9353169192097.obs;
  RxDouble lon = 106.87421172580028.obs;
  RxBool isLoadingWeather = false.obs;
}

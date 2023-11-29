import 'package:get/get.dart';

class HomeState {
  RxMap<String, dynamic> userData = RxMap();
  RxMap<String, dynamic> creatingRideData = RxMap();
  RxBool obscureText = true.obs;
  RxString weatherIcon = ''.obs;
  RxDouble weatherTemp = 0.0.obs;
  RxDouble lat = 47.9353169192097.obs;
  RxDouble lon = 106.87421172580028.obs;
  RxBool isLoadingWeather = false.obs;
  RxInt pricePerKm = 500.obs;
  RxMap<String, dynamic> rides = RxMap();
  RxString carSerialNo = ''.obs;
}

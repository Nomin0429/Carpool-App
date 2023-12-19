import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomeState {
  RxMap<String, dynamic> userData = RxMap();
  RxMap<String, dynamic> creatingRideData = RxMap();
  RxBool obscureText = true.obs;
  RxString weatherIcon = ''.obs;
  RxDouble weatherTemp = 0.0.obs;
  double lat = 47.9353169192097;
  double lon = 106.87421172580028;
  RxBool isLoadingWeather = false.obs;
  RxInt pricePerKm = 500.obs;
  RxMap<String, dynamic> doneRides = RxMap();
  RxMap<String, dynamic> openRides = RxMap();
  RxMap<String, dynamic> startedRides = RxMap();
  RxString carSerialNo = ''.obs;
  RxString currentAddress = ''.obs;
  bool locationPermission = false;
  RxInt price = 0.obs;
  RxList<Map<String, dynamic>> locSuggestions = RxList();
  Map<String, List<Map<String, dynamic>>> searchLocationCache = {};
  RxMap<String, dynamic> driverData = RxMap();
  List<Map<String, dynamic>> stops = [];
  String apikey = 'AIzaSyD--mA5UzhKqzebPyHeAUlxNRfD9ka_bP8';
  RxMap<String, dynamic> transactions = RxMap();
  RxList<List<String>> allRoutesBusStops = RxList();
  RxList<String> selectedStops = RxList();
}

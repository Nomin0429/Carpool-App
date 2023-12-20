import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HomeState {
  RxMap<String, dynamic> userData = RxMap();
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
  RxBool isPossibleStopsGenerated = false.obs;
  RxMap<String, dynamic> riderData = RxMap();
  List<Map<String, dynamic>> stops = [];
  String apikey = 'AIzaSyD--mA5UzhKqzebPyHeAUlxNRfD9ka_bP8';
  RxMap<String, dynamic> transactions = RxMap();
  RxList<List<String>> allRoutesBusStops = RxList();
  RxList<String> selectedStops = RxList();
  RxInt priceToPay = 0.obs;
  RxMap<String, dynamic> paymentData = RxMap();
}

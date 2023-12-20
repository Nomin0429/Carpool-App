import 'dart:async';
import 'dart:developer';
import 'package:carpool_app/home/state/home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../login/view/login_screen.dart';
import '../../signup/component/auto_close_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  HomeState homeState = HomeState();
  late final Function debouncedUpdateSuggestions;
  TimeOfDay? selectedTime;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  HomeController() {
    debouncedUpdateSuggestions = debounce(() {}, 500);
  }

  ///driver-n inputiin controller-uud
  final pricePerKmController = TextEditingController();
  final originController = TextEditingController();
  final destinationController = TextEditingController();
  final possibleStopsController = TextEditingController();
  final dayController = TextEditingController();
  final carController = TextEditingController();
  final seatsAvailableController = TextEditingController();

  ///rider-n inputiin controller-uud
  final riderOriginController = TextEditingController();
  final riderDestinationController = TextEditingController();
  final riderSeatController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    getGreeting();
    loadUserData();
    await getWeatherData(homeState.lat, homeState.lon);
    listenToRides();
    fetchTransactions(getUserId());
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
      homeState.weatherIcon.value = 'https:${response.data['current']['condition']['icon']}';
      homeState.weatherTemp.value = response.data['current']['temp_c'];
    } else {
      log('Амжилтгүй');
    }
    homeState.isLoadingWeather.value = true;
  }

  ///Хэрэглэгчийн мэдээллийг database-с авах функц
  Future<Map<String, dynamic>> fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception('Хэрэглэгчийн мэдээлэл олдсонгүй');
      }
    } else {
      throw Exception('Ийм хэрэглэгч бүртгүүлээгүй байна');
    }
  }

  ///Нэвтэрсэн хэрэглэгчийн id-г авах
  String getUserId() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return currentUser!.uid;
  }

  ///userdata variable-д database-с хэрэглэгчийн мэдээллийг аван олгох
  void loadUserData() async {
    try {
      Map<String, dynamic> data = await fetchUserData();
      homeState.userData.assignAll(data);
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }

  ///update userdata
  Future<void> updateUserProfile(String name, String email, String phone, String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Map<String, String> updateData = {};

      if (name.isNotEmpty) updateData['name'] = name;
      if (phone.isNotEmpty) updateData['phone'] = phone;

      try {
        if (updateData.isNotEmpty) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).update(updateData);
        }

        //email update hiih
        if (email.isNotEmpty && email != user.email) {
          await user.updateEmail(email);
          if (updateData.isNotEmpty) {
            await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'email': email});
          }
        }

        // password update hiih
        if (newPassword.isNotEmpty) {
          await user.updatePassword(newPassword);
          await FirebaseAuth.instance.signOut();
        }

        await fetchAndUpdateUserData();

        Get.back();
        Get.dialog(
          const AutoCloseDialog(
            title: 'Амжилттай',
            content: 'Таны мэдээлэл амжилттай солигдлоо',
          ),
        );

        log('Бүртгэл амжилттай шинэчлэгдлээ.');
      } catch (e) {
        Get.dialog(
          const AutoCloseDialog(
            title: 'Амжилтгүй',
            content: 'Та түр хүлээгээд дахин оролдоно уу',
          ),
        );
        log('Бүртгэл шинэчлэхэд алдаа гарлаа: $e');
      }
    }
  }

  ///update hiisn datag userData variable-d ugch bga function
  Future<void> fetchAndUpdateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          homeState.userData.value = userDoc.data() as Map<String, dynamic>;
          update();
        }
      } catch (e) {
        log('Хэрэглэгчийн мэдээлэл татахад алдаа гарлаа: $e');
      }
    }
  }

  ///Хэрэглэгчийн мэдээлэлд машины мэдээлэл update хийх функц
  Future<bool> addCarToUser(Map<String, String> carData) async {
    String? userId = getUserId();
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'cars': FieldValue.arrayUnion([carData])
      });
      homeState.userData['cars'].add(carData);
      return true;
    } catch (e) {
      log('Машин нэмэхэд алдаа гарлаа: $e');
      return false;
    }
  }

  // DateTime combineDateTime(TimeOfDay? timeOfDay) {
  //   final now = DateTime.now();
  //   final date = dayController.text == "Today" ? now : DateTime(now.year, now.month, now.day + 1);
  //   return DateTime(
  //     date.year,
  //     date.month,
  //     date.day,
  //     timeOfDay?.hour ?? 0,
  //     timeOfDay?.minute ?? 0,
  //   );
  // }
  Future<void> getUserDataByUserId(String userId) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      DocumentSnapshot<Object?> doc = await docRef.get();

      if (doc.exists) {
        homeState.riderData.value = doc.data() as Map<String, dynamic>;
      } else {
        log('No data found for user');
        homeState.riderData.value = {};
      }
    } catch (e) {
      log('Error fetching user data: $e');
      homeState.riderData.value = {};
    }
  }

  ///Жолоочийн үүсгэсэн ride db-д бичих
  Future<bool> createRide(
      String destination, String origin, List possibleStops, String day, DateTime time, String selectedCar, int seatsAvailable, int price) async {
    CollectionReference rides = FirebaseFirestore.instance.collection('rides');
    String userId = getUserId();

    try {
      await rides.add({
        'driverId': userId,
        'rideStatus': 'open',
        'destination': destination,
        'origin': origin,
        'possibleStops': possibleStops,
        'day': day,
        'startTime': time,
        'car': selectedCar,
        'seatsAvailable': seatsAvailable,
        'pricePerKm': price,
        'riders': {},
      });

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'role': 'driver',
      });
      clearFormFields();
      log('Ride created successfully');

      return true;
    } catch (e) {
      log('Error creating ride: $e');
      return false;
    }
  }

  Future<bool> updateRiders(String rideId, String origin, String destination, int bookedSeats) async {
    if (currentUser == null) {
      log('No current user found');
      return false;
    }

    DocumentReference rideDoc = _firestore.collection('rides').doc(rideId);

    return _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(rideDoc);

      if (!snapshot.exists) {
        log('Ride does not exist');
        return false;
      }

      Map<String, dynamic>? rideData = snapshot.data() as Map<String, dynamic>?;
      if (rideData == null) {
        log('Ride data is null');
        return false;
      }

      // Modification: Adding riderId in the riders map
      Map<String, dynamic> riders = rideData['riders'] ?? {};
      riders[currentUser!.uid] = {
        'riderId': currentUser!.uid, // Add riderId
        'origin': origin,
        'destination': destination,
        'bookedSeats': bookedSeats,
      };

      int currentSeatsAvailable = rideData['seatsAvailable'] ?? 0;
      int newSeatsAvailable = currentSeatsAvailable - bookedSeats;
      newSeatsAvailable = newSeatsAvailable < 0 ? 0 : newSeatsAvailable;

      transaction.update(rideDoc, {
        'riders': riders,
        'seatsAvailable': newSeatsAvailable,
      });

      log('Ride updated successfully');
      return true;
    }).catchError((e) {
      log('Error updating ride: $e');
      return false;
    });
  }

  ///Ride үүсгэсний дараа бүх хэсгийг цэвэрлэх функц
  void clearFormFields() {
    originController.text = '';
    destinationController.text = '';
    possibleStopsController.text = '';
    dayController.text = 'Өнөөдөр';
    carController.text = '';
    seatsAvailableController.text = '';
  }

  Function debounce(VoidCallback function, int milliseconds) {
    Timer? timer;

    return () {
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(Duration(milliseconds: milliseconds), function);
    };
  }

  ///Зорчигчийн оруулсан суух, буух цэгийн хоорондох зайг тооцоолох функц
  Future<void> getDistanceFromBackend(String origin, String destination, int bookedSeats) async {
    final String apiKey = homeState.apikey;
    final String encodedOrigin = Uri.encodeComponent(origin);
    final String encodedDestination = Uri.encodeComponent(destination);

    final String url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
        '?origins=$encodedOrigin'
        '&destinations=$encodedDestination'
        '&units=imperial'
        '&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'OK') {
          final element = jsonResponse['rows'][0]['elements'][0];

          if (element['status'] == 'OK') {
            final distanceInMeters = element['distance']['value'];
            debugPrint('Distance between $origin and $destination: $distanceInMeters meters');
            homeState.priceToPay.value = (distanceInMeters / 1000).round() * 500 * bookedSeats;
          } else {
            throw Exception('Element status is not OK: ${element['status']}');
          }
        } else {
          throw Exception('Response status is not OK: ${jsonResponse['status']}');
        }
      } else {
        throw Exception('Failed to load distance: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Failed to get distance from backend: $e');
    }
  }

  ///Location suggestion авах функц
  Future<List<Map<String, dynamic>>> getLocationSuggestions(String query, String apikey) async {
    if (homeState.searchLocationCache.containsKey(query)) {
      var cachedValue = homeState.searchLocationCache[query] as List<Map<String, dynamic>>;
      return cachedValue;
    }
    Uri url = Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json',
        {'input': query, 'language': 'mn', 'components': 'country:MN', 'location': '47.9200,106.9200', 'radius': '50000', 'key': apikey});

    final response = await http.get(url);
    log("came here: ${response.statusCode}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Map<String, dynamic>> suggestions = [];
      for (var prediction in data['predictions']) {
        suggestions.add({
          'name': prediction['description'],
        });
        log('suggests: $suggestions');
      }

      homeState.searchLocationCache[query] = suggestions;
      log('nomio locations $suggestions');

      return suggestions;
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  ///location suggestion update hiih function
  Future<void> updateSuggestions(String query) async {
    if (query.isNotEmpty) {
      try {
        List<Map<String, dynamic>> fullSuggestions = await getLocationSuggestions(query, homeState.apikey);
        homeState.locSuggestions.assignAll(fullSuggestions);
      } catch (e) {
        homeState.locSuggestions.clear();
      }
    } else {
      homeState.locSuggestions.clear();
    }
  }

  ///Route suggestion
  Future<List<List<Map<String, dynamic>>>> getRoute(String origin, String destination) async {
    Uri url = Uri.https('maps.googleapis.com', 'maps/api/directions/json',
        {'origin': origin, 'destination': destination, 'alternatives': 'true', 'key': homeState.apikey});

    var response = await http.get(url);
    var data = json.decode(response.body);

    List<List<Map<String, dynamic>>> allRoutes = [];

    if (data['routes'].isNotEmpty) {
      for (var route in data['routes']) {
        List<Map<String, dynamic>> routePoints = [];

        for (var step in route['legs'][0]['steps']) {
          double lat = step['end_location']['lat'];
          double lng = step['end_location']['lng'];
          routePoints.add({'lat': lat, 'lng': lng});
        }

        allRoutes.add(routePoints);
        log('all $allRoutes');
      }
    }
    return allRoutes;
  }

  Future<List<List<String>>> findBusStopsNearRoutes(List<List<Map<String, dynamic>>> allRoutes) async {
    for (var routePoints in allRoutes) {
      List<String> busStops = [];

      for (var point in routePoints) {
        Uri placesUrl = Uri.https('maps.googleapis.com', '/maps/api/place/nearbysearch/json',
            {'location': '${point['lat']},${point['lng']}', 'radius': '1000', 'type': 'bus_station', 'language': 'mn', 'key': homeState.apikey});

        var response = await http.get(placesUrl);
        var data = json.decode(response.body);

        for (var result in data['results']) {
          busStops.add(result['name']);
        }
      }

      homeState.allRoutesBusStops.add(busStops.toSet().toList());
    }

    return homeState.allRoutesBusStops;
  }

  Future<void> fetchRouteAndFindBusStops() async {
    try {
      homeState.isPossibleStopsGenerated.value = false;
      List<List<Map<String, dynamic>>> routePoints = await getRoute(originController.text, destinationController.text);
      log('routePoints: $routePoints');

      List<List<String>> allRoutesBusStops = await findBusStopsNearRoutes(routePoints);

      for (var i = 0; i < allRoutesBusStops.length; i++) {
        log('Bus stops for route ${i + 1}: ${allRoutesBusStops[i]}');
      }
      homeState.isPossibleStopsGenerated.value = true;
    } catch (e) {
      log('Error: $e');
    }
  }

  ///Зорчигч аяллын дэлгэрэнгүйг харах үед жолоочийн дэлгэрэнгүй мэдээллийг авах функц
  Future<DocumentSnapshot> getDriverDataByDocumentId(String docId) async {
    DocumentReference docRef = _firestore.collection('users').doc(docId);

    try {
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        log('Document data: ${doc.data()}');
        return doc;
      } else {
        log('No such document!');
        return Future.error('No such document!');
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }

  Future<void> updateDriverData(ride) async {
    await getDriverDataByDocumentId(ride['driverId']).then((doc) {
      if (doc.exists) {
        homeState.driverData.value = doc.data() as Map<String, dynamic>;
      } else {}
    }).catchError((error) {
      log("Error fetching driver data: $error");
    });
  }

  ///rides collection-ий real-time update-уудыг сонсож байгаа функц
  void listenToRides() {
    FirebaseFirestore.instance.collection('rides').snapshots().listen((snapshot) {
      homeState.openRides.clear();
      homeState.startedRides.clear();
      homeState.doneRides.clear();

      for (var doc in snapshot.docs) {
        var rideData = doc.data();
        var rideStatus = rideData['rideStatus'];

        if (rideStatus == 'open') {
          homeState.openRides[doc.id] = rideData;
        } else if (rideStatus == 'started') {
          homeState.startedRides[doc.id] = rideData;
        } else if (rideStatus == 'done') {
          homeState.doneRides[doc.id] = rideData;
        }
      }
    });
  }

  ///Хэрэглэгчийн дансны үлдэгдэл шинэчлэх функц
  Future<bool> updateUserBalance(int price, String description) async {
    bool success = false;

    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(getUserId());
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userDoc);

        if (snapshot.exists) {
          Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

          if (userData != null && userData.containsKey('wallet') && userData['wallet'] is Map<String, dynamic>) {
            double currentBalance = (userData['wallet']['balance'] ?? 0).toDouble();
            double newBalance = currentBalance + price.toDouble();

            transaction.update(userDoc, {'wallet.balance': newBalance.toInt()});
            homeState.userData['wallet']['balance'] = newBalance.toInt();

            await createTransaction(getUserId(), description, price.toInt());
            fetchTransactions(getUserId());
          }
        }
      });

      log('Хэрэглэгчийн дансны үлдэгдэл амжилттай шинэчлэгдлээ.');
      success = true;
    } catch (e) {
      log('Error updating user balance: $e');
      success = false;
    }
    return success;
  }

  ///Payment үүсгэх функц
  Future<bool> createPayment(String creatorId, String tripId, int amount) async {
    try {
      CollectionReference payments = _firestore.collection('payments');

      String paymentId = payments.doc().id;
      Timestamp timestamp = Timestamp.now();

      Map<String, dynamic> paymentData = {
        'paymentId': paymentId,
        'creatorId': creatorId,
        'tripId': tripId,
        'amount': amount,
        'date': timestamp,
        'status': 'completed',
      };

      await payments.doc(paymentId).set(paymentData);

      debugPrint('Payment created successfully');
      return true;
    } catch (e) {
      debugPrint('Error creating payment: $e');
      return false;
    }
  }

  ///payment-н датаг paymentData хувьсагчид авах функц
  Future<void> fetchPayments({String? rideId}) async {
    try {
      Query query = _firestore.collection('payments').where('creatorId', isEqualTo: getUserId());

      if (rideId != null) {
        query = query.where('tripId', isEqualTo: rideId);
      }

      QuerySnapshot paymentSnapshot = await query.get();

      homeState.paymentData.clear();

      for (var doc in paymentSnapshot.docs) {
        homeState.paymentData[doc.id] = doc.data();
        log('payment dataaaa: ${homeState.paymentData[doc.id]}');
      }

      debugPrint('Payments fetched successfully');
    } catch (e) {
      debugPrint('Error fetching payments: $e');
    }
  }

  ///Transaction үүсгэх функц
  Future<bool> createTransaction(String userId, String transactionType, int amount) async {
    try {
      CollectionReference transactions = FirebaseFirestore.instance.collection('transactions');

      String transactionId = transactions.doc().id;

      Timestamp timestamp = Timestamp.now();

      Map<String, dynamic> transactionData = {
        'transactionId': transactionId,
        'userId': userId,
        'transactionType': transactionType,
        'amount': amount,
        'createdAt': timestamp,
      };

      await transactions.doc(transactionId).set(transactionData);

      log('Transaction created successfully');
      return true;
    } catch (e) {
      log('Error creating transaction: $e');
      return false;
    }
  }

  ///Transactions collection-с нэвтэрсэн хэрэглэгчийн гүйлгээнүүдийг авах
  void fetchTransactions(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('transactions').where('userId', isEqualTo: userId).get();

      homeState.transactions.clear();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        homeState.transactions[doc.id] = doc.data();
      }
    } catch (e) {
      log('Error fetching transactions: $e');
    }
  }

  String getHourMinuteFromTimestamp(dynamic yourTimestampField) {
    if (yourTimestampField != null && yourTimestampField is Timestamp) {
      DateTime dateTime = yourTimestampField.toDate().toLocal();

      String formattedTime = DateFormat.Hm().format(dateTime);

      return formattedTime;
    }

    return '';
  }

  //timestamp-с он сарыг авах функц
  String getDateFromTimestamp(Timestamp? yourTimestampField) {
    if (yourTimestampField != null) {
      DateTime dateTime = yourTimestampField.toDate().toLocal();
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      return formattedDate;
    }
    return '';
  }

  ///Системээс гарах
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginScreen());
  }

  /// Бүртгэл устгах функц
  Future<bool> deleteUserAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
        await user.delete();
        Get.offAll(() => LoginScreen());

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error deleting user account: $e');
      return false;
    }
  }
}

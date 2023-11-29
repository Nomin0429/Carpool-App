import 'dart:developer';
import 'package:carpool_app/home/state/home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/view/login_screen.dart';
import '../../signup/component/auto_close_dialog.dart';

class HomeController extends GetxController {
  HomeState homeState = HomeState();

  final pricePerKmController = TextEditingController();
  final originController = TextEditingController();
  final destinationController = TextEditingController();
  final possibleStopsController = TextEditingController();
  final dayController = TextEditingController();
  final timeController = TextEditingController();
  final carController = TextEditingController();
  final seatsAvailableController = TextEditingController();
  var allFieldsFilled = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getGreeting();
    loadUserData();
    await getWeatherData(homeState.lat.value, homeState.lon.value);
    listenToRides();
    log(homeState.rides.value as String);
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

  ///хэрэглэгчийн мэдээллийг database-с авах функц
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

  ///newtersn hereglegchiin id-g awah
  String getUserId() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return currentUser!.uid;
  }

  ///userdata variable-д утга олгох
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
            title: 'Таны мэдээлэл амжилттай солигдлоо',
          ),
        );

        log('Profile updated successfully.');
      } catch (e) {
        Get.dialog(
          const AutoCloseDialog(
            title: 'Амжилтгүй, та түр хүлээгээд дахин оролдоно уу',
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

  ///Жолооч аялал үүсгэхэд бүх мэдээлэл бөглөгдсөн байгаа эсэхийг шалгах
  void checkIfAllFieldsFilled() {
    allFieldsFilled.value = originController.text.isNotEmpty &&
        destinationController.text.isNotEmpty &&
        possibleStopsController.text.isNotEmpty &&
        dayController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        seatsAvailableController.text.isNotEmpty;
  }

  ///Жолоочийн үүсгэсэн ride db-д бичих
  Future<bool> createRide(
      String destination, String origin, List possibleStops, String day, DateTime time, String selectedCar, int seatsAvailable, double price) async {
    CollectionReference rides = FirebaseFirestore.instance.collection('rides');
    String userId = getUserId();
    List<String> parts = timeController.text.split(':');
    if (parts.length == 2) {
      int hour = int.tryParse(parts[0]) ?? 0;
      int minute = int.tryParse(parts[1]) ?? 0;
      time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
    } else {
      time = DateTime.now();
    }

    try {
      await rides.add({
        'driverId': userId,
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

  ///Ride үүсгэсний дараа бүх хэсгийг цэвэрлэх функц
  void clearFormFields() {
    originController.text = '';
    destinationController.text = '';
    possibleStopsController.text = '';
    dayController.text = 'Өнөөдөр';
    timeController.text = '';
    carController.text = '';
    seatsAvailableController.text = '';
  }

  ///rides collection-ий real-time update-уудыг сонсож байгаа функц
  void listenToRides() {
    FirebaseFirestore.instance.collection('rides').snapshots().listen((snapshot) {
      homeState.rides.clear();
      for (var doc in snapshot.docs) {
        homeState.rides[doc.id] = doc.data();
      }
    });
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

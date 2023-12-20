import 'dart:math';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/login/view/login_screen.dart';
import 'package:carpool_app/signup/state/signup_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../home/view/home_screen.dart';
import '../../login/view/welcome_screen.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final SignUpState state = SignUpState();
  final HomeController homeController = Get.put(HomeController());

  final email = TextEditingController();
  final name = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  bool isValidEmail(String email) {
    Pattern pattern =
        r'^(([^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(email);
  }

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (callback) => _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => const HomeScreen());
  }

  // Утасны дугаар дээр validation хийх функц
  bool isValidPhoneNumber(String value) {
    return value.trim().length == 8 && int.tryParse(value.trim()) != null;
  }

  ///Хэрэглэгч бүртгэх функц
  // Future<bool> registerEmailAndPassword(String email, String password, String name, String phoneNumber) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  //     User? user = userCredential.user;
  //
  //     if (user != null) {
  //       // Давхцаагүй дансны дугаар generate хийх функцийг дуудна.
  //       String uniqueAccountNumber = await generateUniqueAccountNumber();
  //
  //       // Хэтэвчний мэдээллийг тодорхойлох
  //       Map<String, dynamic> initialWallet = {
  //         'accountNumber': uniqueAccountNumber,
  //         'balance': 0,
  //         'transactions': [],
  //       };
  //
  //       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
  //         'name': name,
  //         'phone': phoneNumber,
  //         'email': email,
  //         'role': 'rider',
  //         'joinedAt': FieldValue.serverTimestamp(),
  //         'cars': [],
  //         'rideHistory': {},
  //         'avgRating': 0.0,
  //         'wallet': initialWallet,
  //       });
  //
  //       homeController.loadUserData();
  //       Get.offAll(() => const HomeScreen());
  //       return true;
  //     } else {
  //       Get.to(() => LoginScreen());
  //       return false;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     log('Firebase auth exception: ${e.message}' as num);
  //     return false;
  //   } catch (e) {
  //     log('General exception: $e' as num);
  //     return false;
  //   }
  // }
  //

  Future<bool> registerEmailAndPassword(String email, String password, String name, String phoneNumber) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        String? fcmToken = await FirebaseMessaging.instance.getToken();

        if (fcmToken == null) {
          log("FCM Token is null. Make sure you have proper permissions." as num);
          return false;
        }

        // Давхцаагүй дансны дугаар generate хийх функцийг дуудна.
        String uniqueAccountNumber = await generateUniqueAccountNumber();

        // Хэтэвчний мэдээллийг тодорхойлох
        Map<String, dynamic> initialWallet = {
          'accountNumber': uniqueAccountNumber,
          'balance': 0,
          'transactions': [],
        };

        // Save user data to Firestore, including FCM token
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'phone': phoneNumber,
          'email': email,
          'role': 'rider',
          'joinedAt': FieldValue.serverTimestamp(),
          'cars': [],
          'rideHistory': {},
          'avgRating': 0.0,
          'wallet': initialWallet,
          'fcmToken': fcmToken, // Save the FCM token here
        });

        homeController.loadUserData();
        Get.offAll(() => const HomeScreen());
        return true;
      } else {
        Get.to(() => LoginScreen());
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase auth exception: ${e.message}');
      return false;
    } catch (e) {
      print('General exception: $e');
      return false;
    }
  }

// Цор ганц дансны дугаар generate хийх функц
  Future<String> generateUniqueAccountNumber() async {
    String potentialAccountNumber = '';
    bool isUnique = false;

    // Давхцаагүй дансны дугаар generate хийгдтэл давталт гүйнэ.
    while (!isUnique) {
      potentialAccountNumber = generateAccountNumber();

      // дансны дугаар давхцаж байгаа үгүйг шалгах функц
      bool exists = await checkIfAccountNumberExists(potentialAccountNumber);

      // Хэрвээ generated дансны дугаар давхцаагүй бол түүнийг цор ганц буюу давхардаагүй гэж тэмдэглэнэ.
      if (!exists) {
        isUnique = true;
      }
    }

    return potentialAccountNumber;
  }

// Дансны дугаар санамсаргүйгээр "xxxx xxxx xxx" ийм форматаар үүсгэх функц
  String generateAccountNumber() {
    String part1 = Random().nextInt(10000).toString().padLeft(4, '0');
    String part2 = Random().nextInt(10000).toString().padLeft(4, '0');
    String part3 = Random().nextInt(1000).toString().padLeft(3, '0');

    return '$part1 $part2 $part3';
  }

// Дансны дугаар давхцаж байгаа эсэхийг шалгах функц
  Future<bool> checkIfAccountNumberExists(String accountNumber) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').where('wallet.accountNumber', isEqualTo: accountNumber).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      log('Error checking account number existence: $e' as num);
      return true;
    }
  }
}

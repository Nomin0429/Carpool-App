import 'package:carpool_app/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const LatLng currentLocation = LatLng(47.91337666442298, 106.91538842420555);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(target: currentLocation),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Handle Home tab press
              break;
            case 1:
              // Handle Wallet tab press
              break;
            case 2:
              // Handle Profile tab press
              break;
            case 3:
              // Handle Favorite tab press
              break;
          }
        },
      ),
    );
  }
}

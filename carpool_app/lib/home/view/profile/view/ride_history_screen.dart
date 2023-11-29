import 'package:carpool_app/home/component/home_app_bar.dart';
import 'package:flutter/material.dart';

class MyRidesScreen extends StatelessWidget {
  const MyRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(isHome: false),
            DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Аялалын түүх'),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Удахгүй эхлэх'),
                      Tab(text: 'Дууссан'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    // Image.asset('assets/images/rider_sc.png'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class RideList extends StatelessWidget {
//   final String category;
//
//   const RideList({super.key, required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     // Here you would usually pull your data from a source like Firebase or local storage
//     // For this example, we'll just create a placeholder list of rides
//     final List<String> entries = <String>['A', 'B', 'C'];
//     final List<int> colorCodes = <int>[600, 500, 100];
//
//     return ListView.builder(
//       itemCount: entries.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           height: 50,
//           color: Colors.amber[colorCodes[index]],
//           child: Center(child: Text('Ride ${entries[index]} - $category')),
//         );
//       },
//     );
//   }
// }

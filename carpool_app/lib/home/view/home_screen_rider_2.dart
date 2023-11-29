import 'package:carpool_app/home/component/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreenRider1 extends StatelessWidget {
  const HomeScreenRider1({super.key});

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
                  title: const Text('My Rides'),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Upcoming'),
                      Tab(text: 'Completed'),
                      Tab(text: 'Cancelled'),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    RideList(category: 'Upcoming'),
                    RideList(category: 'Completed'),
                    RideList(category: 'Cancelled'),
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

class RideList extends StatelessWidget {
  final String category;

  const RideList({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Here you would usually pull your data from a source like Firebase or local storage
    // For this example, we'll just create a placeholder list of rides
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Ride ${entries[index]} - $category')),
        );
      },
    );
  }
}

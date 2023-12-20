import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DriverDetailsItem extends GetWidget<HomeController> {
  final Map ride;

  const DriverDetailsItem({super.key, required this.ride});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            SizedBox(height: 110, child: Image.asset('assets/images/user_profile.png')),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 55,
                  width: 170,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.black, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/soyombo.png'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          ride['car'],
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 19),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      controller.homeState.driverData['name'],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      LineAwesomeIcons.star_1,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${controller.homeState.driverData['avgRating']}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      LineAwesomeIcons.phone,
                      color: Colors.green,
                    ),
                    Text(
                      controller.homeState.driverData['phone'],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

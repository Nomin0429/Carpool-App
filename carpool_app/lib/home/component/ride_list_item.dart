import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RideListItem extends StatelessWidget {
  // final String profileImageUrl;
  final String carSerialNo;
  final int seatsAvailable;
  final String origin;
  final String destination;
  final double pricePerKm;
  final String startTime;

  const RideListItem({
    super.key,
    //required this.profileImageUrl,
    required this.carSerialNo,
    required this.seatsAvailable,
    required this.origin,
    required this.destination,
    required this.pricePerKm,
    required this.startTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user2.png'),
                  radius: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 140,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.2), borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset('assets/images/soyombo.png'),
                        const SizedBox(
                          width: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            carSerialNo,
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ///дайгдах үйлдэл
                  },
                  child: const Text(
                    'Дайгдая',
                    style: TextStyle(
                      color: AppColors.yellow900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  startTime,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            LineAwesomeIcons.bullseye,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            origin,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            LineAwesomeIcons.map_marker,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            destination,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '$pricePerKm₮/км',
                      ),
                      Text(
                        '$seatsAvailable сул суудал',
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:carpool_app/style/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RideListItem extends StatelessWidget {
  final Map ride;
  final String textButton;
  final Function onTapTextButton;

  const RideListItem({
    super.key,
    required this.ride,
    required this.textButton,
    required this.onTapTextButton,
  });

  @override
  Widget build(BuildContext context) {
    DateTime startTime = (ride['startTime'] as Timestamp).toDate();
    String formattedTime = DateFormat('HH:mm').format(startTime);

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
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    child: Row(
                      children: [
                        Image.asset('assets/images/soyombo.png'),
                        const SizedBox(
                          width: 9,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            ride['car'],
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      onTapTextButton();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary500),
                    child: Expanded(
                      child: Text(
                        textButton,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
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
                  '${ride['day']} \n $formattedTime',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              ride['origin'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            LineAwesomeIcons.map_marker,
                            color: Colors.black,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              ride['destination'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 9,
                              ),
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
                        '${ride['pricePerKm'].toDouble()}₮/км',
                      ),
                      Text(
                        '${ride['seatsAvailable']} сул суудал',
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

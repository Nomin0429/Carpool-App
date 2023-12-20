import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../style/AppColors.dart';

class RiderItemInDriverHistory extends GetWidget<HomeController> {
  final Map rider;
  final String riderUserId;
  const RiderItemInDriverHistory({
    super.key,
    required this.rider,
    required this.riderUserId,
  });

  @override
  Widget build(BuildContext context) {
    controller.getUserDataByUserId(riderUserId);

    return Column(
      children: <Widget>[
        Row(
          children: [
            const Icon(
              LineAwesomeIcons.user,
              color: AppColors.primary800,
            ),
            Text(
              '${rider['name']}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 7,
            ),
            const Icon(
              LineAwesomeIcons.phone,
              color: AppColors.primary800,
            ),
            Text(
              '${controller.homeState.riderData['phone']}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              LineAwesomeIcons.bullseye,
              color: AppColors.primary800,
            ),
            Text('${rider['origin']}'),
            const Icon(
              LineAwesomeIcons.arrow_right,
              color: AppColors.primary800,
            ),
            const Icon(
              LineAwesomeIcons.map_marker,
              color: AppColors.primary800,
            ),
            Text('${rider['destination']}'),
          ],
        ),
        Text('Захиалсан суудлын тоо: ${rider['bookedSeats']}')
      ],
    );
  }
}

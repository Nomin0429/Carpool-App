import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../style/AppColors.dart';

class RiderItemInDriverHistory extends GetWidget<HomeController> {
  final Map rider;
  final String riderUserId;
  final bool isRideStarted;
  const RiderItemInDriverHistory({
    super.key,
    required this.rider,
    required this.riderUserId,
    required this.isRideStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                LineAwesomeIcons.user,
                color: AppColors.primary800,
              ),
              Obx(
                () => Text(
                  '${controller.homeState.riderData['name']}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                LineAwesomeIcons.phone,
                color: AppColors.primary800,
              ),
              Obx(
                () => Text(
                  '${controller.homeState.riderData['phone']}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Icon(
                LineAwesomeIcons.bullseye,
                color: AppColors.primary800,
              ),
              Expanded(
                child: Text(
                  '${rider['origin'].split(',')[0]}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const Icon(
                LineAwesomeIcons.arrow_right,
                color: AppColors.primary800,
              ),
              const Icon(
                LineAwesomeIcons.map_marker,
                color: AppColors.primary800,
              ),
              Expanded(
                child: Text(
                  '${rider['destination'].split(',')[0]}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          Text('Захиалсан суудлын тоо: ${rider['bookedSeats']}'),
          if (isRideStarted)
            ElevatedButton(
              onPressed: () {},
              child: const Text('Авах'),
            )
        ],
      ),
    );
  }
}

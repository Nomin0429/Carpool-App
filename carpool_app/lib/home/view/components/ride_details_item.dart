import 'dart:developer';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../style/AppColors.dart';

class RideDetailsItem extends GetWidget<HomeController> {
  final Map ride;
  const RideDetailsItem({
    super.key,
    required this.ride,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    LineAwesomeIcons.clock,
                    color: AppColors.primary900,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${ride['day']},  ${controller.getHourMinuteFromTimestamp(ride['startTime'])}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    LineAwesomeIcons.bullseye,
                    color: AppColors.primary900,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      '${ride['origin'].split(',')[0]}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary900),
                    ),
                  ),
                  const Icon(
                    LineAwesomeIcons.arrow_right,
                    color: AppColors.primary900,
                  ),
                  const Icon(
                    LineAwesomeIcons.map_marker,
                    color: AppColors.primary900,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${ride['destination'].split(',')[0]}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary900),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    LineAwesomeIcons.parking,
                    color: AppColors.primary900,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Боломжит зогсоолууд'),
                      onChanged: (String? selectedStop) {
                        log('Selected stop: $selectedStop');
                      },
                      items: (ride['possibleStops'] as List<dynamic>).map((stop) {
                        return DropdownMenuItem<String>(
                          value: stop.toString(),
                          child: Text(
                            stop.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    LineAwesomeIcons.user,
                    color: AppColors.primary900,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${ride['seatsAvailable']} сул суудал',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    LineAwesomeIcons.money_bill,
                    color: AppColors.primary900,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${ride['pricePerKm']} ₮/км',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

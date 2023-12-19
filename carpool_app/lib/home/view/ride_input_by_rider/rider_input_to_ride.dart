import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiderInputToRide extends GetWidget<HomeController> {
  final String hintText;
  final Icon icon;
  final bool isOrigin;
  final Map ride;

  const RiderInputToRide({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.ride,
    required this.isOrigin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(style: BorderStyle.solid)),
        hintText: hintText,
        prefixIcon: icon,
        suffixIcon: DropdownButton<String>(
          underline: Container(),
          onChanged: (String? newValue) {
            textController.text = newValue! ?? '';
            isOrigin ? controller.riderOriginController.text = newValue : controller.riderDestinationController.text = newValue;
          },
          items: [
            DropdownMenuItem<String>(
              value: ride['origin'].toString(),
              child: Text(ride['origin'].toString()),
            ),
            ...(ride['possibleStops'] as List<dynamic>).map((stop) {
              return DropdownMenuItem<String>(
                value: stop.toString(),
                child: Text(stop.toString()),
              );
            }).toList(),
            DropdownMenuItem<String>(
              value: ride['destination'].toString(),
              child: Text(ride['destination'].toString()),
            ),
          ],
        ),
      ),
    );
  }
}

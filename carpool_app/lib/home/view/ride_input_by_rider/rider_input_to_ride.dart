import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../style/AppColors.dart';
import '../../logic/home_controller.dart';

class RiderInputToRide extends GetWidget<HomeController> {
  final String hintText;
  final TextEditingController textController;
  final Icon icon;
  final bool isOrigin;
  final Map ride;

  const RiderInputToRide({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    required this.ride,
    required this.isOrigin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = getDropdownItems(ride);
    String? initialValue = dropdownItems.any((item) => item.value == textController.text) ? textController.text : null;

    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary700),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        hintText: hintText,
        alignLabelWithHint: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: icon,
        ),
      ),
      value: initialValue,
      onChanged: (String? newValue) {
        if (newValue != null) {
          textController.text = newValue;
          if (isOrigin) {
            controller.riderOriginController.text = newValue;
          } else {
            controller.riderDestinationController.text = newValue;
          }
          (context as Element).markNeedsBuild();
        }
      },
      items: dropdownItems,
    );
  }

  List<DropdownMenuItem<String>> getDropdownItems(Map ride) {
    Set<String> valuesSet = {ride['origin'], ride['destination']};
    valuesSet.addAll(List<String>.from(ride['possibleStops']));

    return valuesSet.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}

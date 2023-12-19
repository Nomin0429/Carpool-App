import 'dart:developer';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../style/AppColors.dart';

class CustomAutocomplete extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final double height;
  final double width;
  final Color? borderColor;
  final double? borderRadius;
  final bool isTextBlack;
  final String? inputFormat;
  final bool isOrigin;

  const CustomAutocomplete({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.isTextBlack = false,
    this.inputFormat,
    required this.height,
    required this.width,
    required this.isOrigin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        await homeController.updateSuggestions(textEditingValue.text);
        return homeController.homeState.locSuggestions.map((suggestion) {
          return suggestion['name'] as String;
        });
      },
      onSelected: (String item) async {
        controller.text = item;
        log('Selected item: $item');

        if (!isOrigin) {
          homeController.fetchRouteAndFindBusStops();
        }
      },
      fieldViewBuilder:
          (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
        return SizedBox(
          height: height,
          width: width,
          child: TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: icon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
                borderSide: BorderSide(color: borderColor ?? AppColors.primary300),
              ),
            ),
            style: TextStyle(
              color: isTextBlack ? Colors.black : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}

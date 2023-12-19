import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../style/AppColors.dart';

class CustomDropdownAutocomplete extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final double height;
  final double width;
  final Color? borderColor;
  final double? borderRadius;
  final bool isTextBlack;
  final String? inputFormat;
  final List<String> selectedStops;
  final Function(List<String>) onSelectedStopsChanged;

  const CustomDropdownAutocomplete({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.height,
    required this.width,
    required this.selectedStops,
    required this.onSelectedStopsChanged,
    this.borderColor,
    this.borderRadius,
    this.isTextBlack = false,
    this.inputFormat,
  }) : super(key: key);

  @override
  _CustomDropdownAutocompleteState createState() => _CustomDropdownAutocompleteState();
}

class _CustomDropdownAutocompleteState extends State<CustomDropdownAutocomplete> {
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final query = widget.controller.text;
    homeController.updateSuggestions(query);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          children: widget.selectedStops.map((stop) {
            return Chip(
              label: Text(stop),
              onDeleted: () {
                widget.selectedStops.remove(stop);
                widget.onSelectedStopsChanged(widget.selectedStops);
              },
            );
          }).toList(),
        ),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) async {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            final filteredSuggestions = homeController.homeState.locSuggestions.where((suggestion) {
              return suggestion['name'].toLowerCase().contains(textEditingValue.text.toLowerCase());
            }).map((suggestion) {
              return suggestion['name'] as String;
            }).toList();

            return filteredSuggestions;
          },
          onSelected: (String item) async {
            widget.selectedStops.add(item);
            widget.onSelectedStopsChanged(widget.selectedStops);
            widget.controller.text = '';
          },
          fieldViewBuilder:
              (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
            return SizedBox(
              height: widget.height,
              width: widget.width,
              child: TextField(
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: widget.icon,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 4.0),
                    borderSide: BorderSide(color: widget.borderColor ?? AppColors.primary550),
                  ),
                ),
                style: TextStyle(
                  color: widget.isTextBlack ? Colors.black : Colors.grey,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

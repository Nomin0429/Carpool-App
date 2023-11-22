import 'package:flutter/material.dart';

class FormFieldItem extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final double height;
  final double width;

  const FormFieldItem({super.key, this.controller, required this.hintText, required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(18),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.black12),
              borderRadius: BorderRadius.circular(8.0),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../style/AppColors.dart';
import 'custom_input_formatter.dart';

class FormFieldItem extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final double height;
  final double width;
  final Icon icon;
  final Color? borderColor;
  final double? borderRadius;
  final bool isTextBlack;
  final ValueChanged<String?>? onChanged;
  final String? inputFormat;
  final FormFieldValidator<String>? validator;

  const FormFieldItem({
    Key? key,
    this.controller,
    required this.hintText,
    required this.height,
    required this.width,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.isTextBlack = false,
    this.onChanged,
    this.inputFormat,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormat != null ? [CustomInputFormatter(inputFormat: inputFormat!)] : null,
        decoration: _inputDecoration,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  InputDecoration get _inputDecoration {
    return InputDecoration(
      prefixIcon: icon,
      contentPadding: const EdgeInsets.all(18),
      hintText: hintText,
      hintStyle: TextStyle(
        color: isTextBlack ? Colors.black : Colors.grey,
        fontWeight: FontWeight.w500,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? AppColors.primary300, width: 1),
        borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? AppColors.primary300, width: 1),
        borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
      ),
    );
  }
}

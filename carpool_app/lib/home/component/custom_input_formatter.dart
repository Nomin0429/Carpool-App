import 'package:flutter/services.dart';

class CustomInputFormatter extends TextInputFormatter {
  final String inputFormat;

  CustomInputFormatter({required this.inputFormat});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (inputFormat == 'hh:mm') {
      if (text.length == 3) {
        return newValue.copyWith(
          text: '${text.substring(0, 2)}:${text.substring(2)}',
          selection: TextSelection.collapsed(offset: text.length + 1),
        );
      }
    }
    return newValue;
  }
}

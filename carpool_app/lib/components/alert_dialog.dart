import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAlertDialog extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final String onTapText;

  const ShowAlertDialog({Key? key, required this.onTap, required this.title, required this.onTapText, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary900),
      ),
      content: Text(subtitle),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Болих',
            style: TextStyle(fontSize: 14, color: AppColors.textInfo),
          ),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: Text(
            onTapText,
            style: const TextStyle(fontSize: 14, color: Colors.red),
          ),
          onPressed: () {
            onTap();
          },
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String title;
  final String contentText;
  final String confirmButtonText;
  final String cancelButtonText;
  final Color color;

  const RideDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.title,
    required this.contentText,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: Text(
            cancelButtonText,
            style: TextStyle(color: color),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          onPressed: onConfirm,
          child: Text(
            confirmButtonText,
            style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../style/AppColors.dart';

class AutoCloseDialog extends StatelessWidget {
  final String title;
  final String content;

  const AutoCloseDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.primary300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              content,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

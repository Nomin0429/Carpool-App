import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';

class SuccessDialogWidget extends StatelessWidget {
  final String title;
  final int durationInSeconds;

  const SuccessDialogWidget({
    super.key,
    required this.title,
    this.durationInSeconds = 3,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSuccessDialog(context);
    });

    return Container();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: AppColors.primary300)),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: durationInSeconds), () {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    });
  }
}

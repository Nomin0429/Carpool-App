import 'package:flutter/material.dart';

class AutoCloseDialog extends StatelessWidget {
  final String title;
  final bool autoClose;
  final int durationInSeconds;

  const AutoCloseDialog({
    Key? key,
    required this.title,
    this.autoClose = true,
    this.durationInSeconds = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog(context);
    });

    return Container();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title),
                const SizedBox(height: 20),
                if (autoClose) const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );

    // Automatically close the dialog after a specified duration if autoClose is true
    if (autoClose) {
      Future.delayed(Duration(seconds: durationInSeconds), () {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      });
    }
  }
}

import 'package:flutter/material.dart';

class MyNumberWidget extends StatelessWidget {
  final String number;
  final Function() onTap;

  const MyNumberWidget({required this.number, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

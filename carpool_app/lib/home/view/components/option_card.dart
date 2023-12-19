import 'package:flutter/material.dart';

import '../../../style/AppColors.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isDriver;
  final double cardHeight;
  final VoidCallback? onTap;

  const OptionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.isDriver,
    required this.cardHeight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: cardHeight,
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: cardHeight,
                width: cardHeight - 30,
                decoration: BoxDecoration(
                  color: isDriver ? AppColors.error400 : AppColors.primary300,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(5),
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset(isDriver ? 'assets/images/driver_home.png' : 'assets/images/rider_home.png')),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(fontSize: 11, color: AppColors.textInfo, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

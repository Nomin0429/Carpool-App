import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../style/AppColors.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool endIcon;
  final Color? textColor;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.endIcon = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.primary300.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: AppColors.primary300,
          )),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.black, fontSize: 14),
      ),
      trailing: endIcon
          ? Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                color: Colors.grey,
              ))
          : null,
    );
  }
}

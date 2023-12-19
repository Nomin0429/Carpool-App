import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../logic/home_controller.dart';
import '../../../../state/home_state.dart';

/// Апп-н home хуудаснаас үнийн дүнг хялбар сонгох зорилготой.
class MyChoosePrice extends GetWidget<HomeController> {
  final int price;
  const MyChoosePrice({required this.price, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeState state = controller.homeState;

    return InkWell(
      onTap: () {
        state.price.value = price;
      },
      child: Obx(
        () => Container(
          margin: const EdgeInsets.only(right: 4.5),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: state.price.value == price ? Colors.white : AppColors.primary300,
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 40.0,
          child: Center(
            child: Text(
              '$price',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: state.price.value == price ? AppColors.primary900 : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

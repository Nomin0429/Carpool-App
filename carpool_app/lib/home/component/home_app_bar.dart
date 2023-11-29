import 'package:carpool_app/home/view/profile/view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../components/go_back_button.dart';
import '../../components/image_button_widget.dart';

class HomeAppBar extends StatelessWidget {
  final bool isHome;
  const HomeAppBar({super.key, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          isHome ? Container() : const GoBackButton(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => ProfileScreen());
                },
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: ImageButtonWidget(
                    imgUrl: 'assets/images/user_profile.png',
                    size: 50,
                    shape: ShapeType.circle,
                  ),
                ),
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(LineAwesomeIcons.bell),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

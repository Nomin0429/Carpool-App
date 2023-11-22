import 'package:flutter/cupertino.dart';
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
              const Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ImageButtonWidget(
                    imgUrl: 'assets/images/profile_pic.jpg',
                    size: 50,
                    shape: ShapeType.circle,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: ImageButtonWidget(
                    imgUrl: 'assets/icons/notif_icon.png',
                    size: 50,
                    shape: ShapeType.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

///Буцах товчны widget
class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: const Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Image(
                  height: 14,
                  image: AssetImage('assets/icons/angleLeft.png'),
                ),
              ),
              Text(
                'Буцах',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

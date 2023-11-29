import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
                child: Icon(LineAwesomeIcons.angle_left),
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

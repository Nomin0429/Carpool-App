import 'package:flutter/material.dart';
import '../../../../style/AppColors.dart';

class MyCarsItem extends StatelessWidget {
  final List<Map<String, String>> cars;

  const MyCarsItem({Key? key, required this.cars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          var car = cars[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: AppColors.primary300)),
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    'assets/images/car_icon.jpg',
                    fit: BoxFit.fill,
                  )),
              title: Text(
                car['serialNo'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              subtitle: Text('${car['model']}'),
            ),
          );
        },
      ),
    );
  }
}

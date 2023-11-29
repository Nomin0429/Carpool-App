import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../components/success_dialog_widget.dart';

class AddCarDialog extends GetWidget<HomeController> {
  AddCarDialog({super.key});

  final HomeController _homeController = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();
  final _carModelController = TextEditingController();
  final _carNumberController = TextEditingController();
  final _carLettersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _carNumberController,
                      decoration: const InputDecoration(
                        labelText: '',
                        icon: Icon(LineAwesomeIcons.hashtag),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length != 4) {
                          return 'Улсын дугаарын 4 оронтой тоо оруулна уу';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10), // Spacing between fields
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _carLettersController,
                      decoration: InputDecoration(
                        labelText: '',
                        icon: SizedBox(height: 25, child: Image.asset('assets/icons/car_serialNo.png')),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length != 3 || !RegExp(r'^[A-Яa-я]+$').hasMatch(value)) {
                          return 'Улсын дугаарын 3 үсэг оруулна уу';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _carModelController,
                decoration: const InputDecoration(
                  labelText: 'Машины модел',
                  icon: Icon(LineAwesomeIcons.car),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Машины моделоо оруулна уу';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.back();
                    final carData = {
                      'serialNo': _carNumberController.text + _carLettersController.text,
                      'model': _carModelController.text,
                    };
                    bool success = _homeController.addCarToUser(carData) as bool;
                    success
                        ? Get.dialog(const SuccessDialogWidget(
                            title: 'Амжилттай',
                          ))
                        : Get.dialog(const SuccessDialogWidget(
                            title: 'Амжилтгүй',
                          ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Машин нэмэх'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

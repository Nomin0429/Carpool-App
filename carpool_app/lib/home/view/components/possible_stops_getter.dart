import 'package:carpool_app/home/view/components/custom_autocomplete.dart';
import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class PossibleStopsGetter extends GetWidget<HomeController> {
  const PossibleStopsGetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    void onSelected(String stop) {
      if (!homeController.homeState.selectedStops.contains(stop) && stop.isNotEmpty) {
        homeController.homeState.selectedStops.add(stop);
        controller.possibleStopsController.text = controller.homeState.selectedStops.join(', ');
      }
    }

    return Column(
      children: [
        Autocomplete<String>(optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          return homeController.homeState.allRoutesBusStops
              .expand((i) => i)
              .where((option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
        }, onSelected: (String selection) {
          onSelected(selection);
        }, fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomAutoComplete(
              controller: textEditingController,
              hintText: 'Зогсоол нэмж оруулах',
              icon: const Icon(
                LineAwesomeIcons.parking,
                color: AppColors.primary300,
              ),
              height: 70,
              width: 285,
              isOrigin: true,
            ),
            IconButton(
                onPressed: () {
                  onSelected(textEditingController.text);
                  textEditingController.clear();
                },
                icon: const Icon(
                  LineAwesomeIcons.plus_circle,
                  color: AppColors.primary300,
                )),
          ]);
        }),
        Obx(
          () => SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: MultiSelectDialogField(
              buttonIcon: const Icon(
                LineAwesomeIcons.arrow_down,
                color: AppColors.primary300,
              ),
              items: homeController.homeState.allRoutesBusStops.expand((i) => i).toSet().map((stop) => MultiSelectItem<String>(stop, stop)).toList(),
              title: const Text("Боломжит зогсоолууд"),
              onConfirm: (values) {
                for (var stop in values) {
                  onSelected(stop as String);
                }
              },
              chipDisplay: MultiSelectChipDisplay.none(),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primary300,
                    width: 2.0,
                  ),
                ),
              ),
              confirmText: const Text("Болсон"),
            ),
          ),
        ),
        Obx(() => Wrap(
              spacing: 8.0,
              children: homeController.homeState.selectedStops
                  .map((stop) => Chip(
                        label: Text(stop),
                        onDeleted: () {
                          homeController.homeState.selectedStops.remove(stop);
                        },
                      ))
                  .toList(),
            )),
      ],
    );
  }
}

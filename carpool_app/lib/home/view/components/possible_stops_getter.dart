import 'package:carpool_app/home/view/components/custom_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class PossibleStopsGetter extends GetWidget<HomeController> {
  PossibleStopsGetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    void onSelected(String stop) {
      if (!homeController.homeState.selectedStops.contains(stop) && stop.isNotEmpty) {
        homeController.homeState.selectedStops.add(stop);
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
          // return TextField(
          //   controller: textEditingController,
          //   focusNode: focusNode,
          //   decoration: InputDecoration(
          //     hintText: 'Type and add a stop',
          //     suffixIcon: IconButton(
          //       icon: const Icon(Icons.add),
          //       onPressed: () {
          //         onSelected(textEditingController.text);
          //         textEditingController.clear();
          //       },
          //     ),
          //   ),
          // );
          return Row(children: [
            CustomAutocomplete(
              controller: textEditingController,
              hintText: 'Та өөрийн хүссэн зогсоолыг нэмж оруулах боломжтой',
              icon: const Icon(LineAwesomeIcons.parking),
              height: 70,
              width: 300,
              isOrigin: true,
            ),
            IconButton(
                onPressed: () {
                  onSelected(textEditingController.text);
                  textEditingController.clear();
                },
                icon: const Icon(LineAwesomeIcons.plus_circle)),
          ]);
        }),
        Obx(
          () => MultiSelectDialogField(
            items: homeController.homeState.allRoutesBusStops.expand((i) => i).toSet().map((stop) => MultiSelectItem<String>(stop, stop)).toList(),
            title: const Text("Select Bus Stops"),
            onConfirm: (values) {
              for (var stop in values) {
                onSelected(stop as String);
              }
            },
            chipDisplay: MultiSelectChipDisplay.none(),
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

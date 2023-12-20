import 'dart:developer';
import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../../signup/component/auto_close_dialog.dart';
import '../../../../logic/home_controller.dart';
import '../../../../state/home_state.dart';
import 'my_choose_price.dart';
import 'my_number_widget.dart';

class AddMoneyToWallet extends GetWidget<HomeController> {
  const AddMoneyToWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeState state = controller.homeState;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineAwesomeIcons.arrow_left)),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Мөнгөн дүн',
                                style: TextStyle(fontSize: 13),
                              ),
                              Obx(
                                () => Text(
                                  '${state.price.value}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 56.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            children: [
                              Text(
                                '₮',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary900,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Expanded(child: MyChoosePrice(price: 5000)),
                        Expanded(child: MyChoosePrice(price: 10000)),
                        Expanded(child: MyChoosePrice(price: 20000)),
                        Expanded(child: MyChoosePrice(price: 30000)),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          // border: Border.all(color: AppColors.primary200),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '1',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}1');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '2',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}2');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '3',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}3');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '4',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}4');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '5',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}5');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '6',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}6');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '7',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}7');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '8',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}8');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '9',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}9');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '000',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}000');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: '0',
                                      onTap: () {
                                        state.price.value = int.parse('${state.price}0');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: MyNumberWidget(
                                      number: 'x',
                                      onTap: () {
                                        if ('${state.price.value}'.isNotEmpty) {
                                          state.price.value = int.parse(
                                            '${state.price.value}'.substring(
                                                      0,
                                                      '${state.price.value}'.length - 1,
                                                    ) ==
                                                    ''
                                                ? '0'
                                                : '${state.price.value}'.substring(0, '${state.price.value}'.length - 1),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        bool success = await controller.updateUserBalance(state.price.value, 'charge');
                        log('Success: $success'); // Debug point

                        if (success) {
                          Get.dialog(const AutoCloseDialog(
                            title: 'Амжилттай',
                            content: 'Таны данс амжилттай цэнэглэгдлээ.',
                          ));
                          log('Dialog shown'); // Debug point
                          Future.delayed(const Duration(seconds: 3), () {
                            Get.back();
                            log('Get.back() executed'); // Debug point
                          });
                        } else {
                          Get.dialog(const AutoCloseDialog(
                            title: 'Амжилтгүй',
                            content: 'Та дахин оролдоно уу',
                          ));
                        }
                        log('nomio balance: ${state.userData['wallet']['balance']}');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Цэнэглэх'),
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: double.infinity,
            //   width: double.infinity,
            //   child: Visibility(
            //     visible: state.userData.isNotEmpty,
            //     child: Center(
            //       child: Container(
            //         height: 200,
            //         width: 300,
            //         padding: const EdgeInsets.all(16),
            //         color: Colors.white,
            //         child: IntrinsicHeight(
            //           child: Column(
            //             children: [
            //               // Image.asset(
            //               //   'assets/icons/ic_warning.png',
            //               //   height: 77,
            //               //   width: 90,
            //               // ),
            //               const SizedBox(
            //                 height: 10,
            //               ),
            //               const Text('Нэвтэрнэ үү.'),
            //               const SizedBox(
            //                 height: 12,
            //               ),
            //               ElevatedButton(
            //                 key: const Key('exitDialog'),
            //                 onPressed: () {
            //                   Get.offAllNamed('/login');
            //                 },
            //                 child: const Text('Нэвтрэх'),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

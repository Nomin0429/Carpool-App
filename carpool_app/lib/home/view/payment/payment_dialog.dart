import 'package:carpool_app/home/view/components/alert_dialog.dart';
import 'package:carpool_app/home/view/profile/view/wallet/add_money_to_wallet.dart';
import 'package:carpool_app/signup/component/auto_close_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/style/AppColors.dart';

class PaymentDialog extends GetWidget<HomeController> {
  final String rideID;
  final String origin;
  final String destination;
  final int bookedSeats;
  const PaymentDialog({
    super.key,
    required this.rideID,
    required this.origin,
    required this.destination,
    required this.bookedSeats,
  });

  @override
  Widget build(BuildContext context) {
    final double distance = controller.homeState.priceToPay.value / 500.0 / bookedSeats;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Төлбөр төлөх',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary300,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Та төлбөр төлөхдөө итгэлтэй байна уу?',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            const Divider(),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Дансны үлдэгдэл',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  "${controller.homeState.userData['wallet']['balance'] ?? 0} ₮",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Таны аяллын замын урт: ${distance.toStringAsFixed(2)} км',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              'Аяллын км-н үнэ: 500 ₮',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Төлөх дүн',
                  style: TextStyle(fontSize: 16.0),
                ),
                Obx(
                  () => Text(
                    "${controller.homeState.priceToPay.value} ₮",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Татгалзах',
                      style: TextStyle(color: AppColors.primary300),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.homeState.userData['wallet']['balance'] >= controller.homeState.priceToPay.value) {
                        await controller.updateUserBalance(controller.homeState.priceToPay.value, 'debit');
                        await controller.createPayment(controller.getUserId(), rideID, controller.homeState.priceToPay.value);
                        controller.updateRiders(
                          rideID,
                          origin,
                          destination,
                          bookedSeats,
                        );
                        Get.back();
                        Get.dialog(
                            const AutoCloseDialog(title: 'Төлбөр төлөлт амжилттай', content: 'Таны төлбөр амжилттай төлөгдөж та аялалд нэгдлээ.'));
                      } else {
                        Get.dialog(
                          ShowAlertDialog(
                            onTap: () => Get.to(const AddMoneyToWallet()),
                            title: 'Амжилтгүй',
                            onTapText: 'Дахин оролдох',
                            subtitle: 'Таны дансны үлдэгдэл хүрэлцэхгүй байна. Та дансаа цэнэглэнэ үү.',
                            isCar: false,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary300,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Төлөх'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

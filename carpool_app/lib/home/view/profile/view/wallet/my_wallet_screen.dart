import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/home/view/profile/view/wallet/add_money_to_wallet.dart';
import 'package:carpool_app/home/view/profile/view/wallet/transaction_item.dart';
import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../components/gradient_text.dart';

class MyWallet extends GetWidget<HomeController> {
  const MyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    String date = '';
    bool isSame = false;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineAwesomeIcons.arrow_left)),
        title: const Text('Таны хэтэвч'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03, horizontal: MediaQuery.of(context).size.width * 0.08),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.darkNavy),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const GradientText(
                        'Үлдэгдэл',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                        gradient: LinearGradient(colors: [
                          AppColors.primary300,
                          Colors.lightBlueAccent,
                          AppColors.primary900,
                        ]),
                      ),
                      Obx(
                        () => GradientText(
                          '${homeController.homeState.userData['wallet']['balance']} ₮',
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                          gradient: const LinearGradient(colors: [
                            AppColors.primary300,
                            Colors.lightBlueAccent,
                            AppColors.primary900,
                          ]),
                        ),
                      ),
                      Text(
                        '${homeController.homeState.userData['wallet']['accountNumber']}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const Divider(),
                      SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(const AddMoneyToWallet());
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0.0),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    LineAwesomeIcons.plus_circle,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Цэнэглэх',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )))
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Гүйлгээний түүх',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                ),
              ),
              homeController.homeState.transactions.isEmpty
                  ? const Text('Та гүйлгээ хийгээгүй байна.')
                  : Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeController.homeState.transactions.length,
                        itemBuilder: (context, index) {
                          final transId = homeController.homeState.transactions.keys.elementAt(index);
                          final transaction = homeController.homeState.transactions[transId];
                          final currentUserId = homeController.getUserId();

                          if (date != homeController.getDateFromTimestamp(transaction['createdAt'])) {
                            isSame = true;
                            date = homeController.getDateFromTimestamp(transaction['createdAt']);
                          } else {
                            isSame = false;
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TransactionItem(
                                  transaction: transaction,
                                  date: isSame ? date : '',
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
            ],
          ),
        ),
      ),
    );
  }
}

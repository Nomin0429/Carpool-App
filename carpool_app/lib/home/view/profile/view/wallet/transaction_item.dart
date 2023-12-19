import 'package:carpool_app/home/logic/home_controller.dart';
import 'package:carpool_app/style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionItem extends StatelessWidget {
  String date;
  dynamic transaction;

  TransactionItem({required this.transaction, this.date = '', Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 12.0,
          ),
          date == ''
              ? Container()
              : Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary300,
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.primary300)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        homeController.getHourMinuteFromTimestamp(transaction['createdAt']),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        transaction['transactionType'] == 'charge' || transaction['transactionType'] == 'income'
                            ? " + ${transaction['amount']} ₮"
                            : " - ${transaction['amount']} ₮",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: transaction['transactionType'] == 'charge' || transaction['transactionType'] == 'income' ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  if (transaction['transactionType'] == 'charge')
                    const Text(
                      "Цэнэглэлт",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  if (transaction['transactionType'] == 'income')
                    const Text(
                      'Орлого',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  if (transaction['transactionType'] == 'debit')
                    const Text(
                      'Зарлага',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  SizedBox(
                    height: 1.0,
                    width: double.infinity,
                    child: Container(
                        //color: MyColors.dividerColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

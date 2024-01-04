import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderItem extends GetView {
  OrderItem({
    required this.orderNo,
    required this.productNumber,
    required this.orderDate,
    required this.orderPrice,
    required this.onTap,
  });
  final String orderNo;
  final String productNumber;
  final String orderDate;
  final String orderPrice;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    titleWidget(title: 'رقم الطلب'),
                    const SizedBox(height: 7),
                    value(value: orderNo)
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget(title: 'عدد المنتجات'),
                    const SizedBox(height: 7),
                    value(value: productNumber)
                  ],
                )
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget(title: 'تاريخ الطلب'),
                    const SizedBox(height: 7),
                    value(value: orderDate)
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget(
                      title: 'السعر',
                    ),
                    const SizedBox(height: 7),
                    value(
                      value: '$orderPrice جنيه',
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text value({required String value}) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: const Color(0xff2d2e49),
      ),
      textAlign: TextAlign.right,
      softWrap: false,
    );
  }

  Text titleWidget({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 11,
        color: const Color(0xffababb7),
      ),
      textAlign: TextAlign.right,
      softWrap: false,
    );
  }
}

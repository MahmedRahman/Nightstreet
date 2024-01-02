import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummary extends GetView {
  final String subTotalPrice;
  final String totalPrice;
  final String shippingPrice;
  final Function()? onCompleteOrderTapped;
  const OrderSummary({
    super.key,
    required this.shippingPrice,
    required this.totalPrice,
    required this.subTotalPrice,
    required this.onCompleteOrderTapped,
  });

  OrderSummary.dummy({
    final Function()? onCompleteOrderTapped,
  })  : subTotalPrice = "2000",
        totalPrice = '2000',
        shippingPrice = "2000",
        onCompleteOrderTapped = onCompleteOrderTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الاجمالي',
                  style: TextStyles.font14mediumBlack,
                  textAlign: TextAlign.right,
                  softWrap: false,
                ),
                Text(
                  '2000 جنيه',
                  style: TextStyles.font14mediumBlack,
                  textAlign: TextAlign.right,
                  softWrap: false,
                ),
              ],
            ),
            SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الشحن',
                  style: TextStyles.font14mediumBlack,
                  textAlign: TextAlign.right,
                  softWrap: false,
                ),
                Text(
                  '2000 جنيه',
                  style: TextStyles.font14mediumBlack,
                  textAlign: TextAlign.right,
                  softWrap: false,
                ),
              ],
            ),
            SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الإجمالي النهائي شامل الضريبة',
                  style: TextStyles.font14mediumBlack,
                  textAlign: TextAlign.right,
                  softWrap: false,
                ),
                Text(
                  '2000 جنيه',
                  style: TextStyles.font14mediumBlack,
                  textAlign: TextAlign.right,
                  softWrap: false,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

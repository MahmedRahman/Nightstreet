import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/orange_bottom.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartSummary extends GetView {
  final String subTotalPrice;
  final String totalPrice;
  final String shippingPrice;
  final Function()? onCompleteOrderTapped;
  const CartSummary({
    super.key,
    required this.shippingPrice,
    required this.totalPrice,
    required this.subTotalPrice,
    required this.onCompleteOrderTapped,
  });

  CartSummary.dummy({
    final Function()? onCompleteOrderTapped,
  })  : subTotalPrice = "2000",
        totalPrice = '2000',
        shippingPrice = "2000",
        onCompleteOrderTapped = onCompleteOrderTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppDimension.appPadding.copyWith(
            bottom: 17,
            top: 10,
          ),
          child: Text(
            'ملخص الطلب',
            style: TextStyles.font14BoldBlack,
            textAlign: TextAlign.right,
            softWrap: false,
          ),
        ),
        Container(
          padding: AppDimension.appPadding,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الاجمالي',
                    style: TextStyles.font14BoldBlack,
                    textAlign: TextAlign.right,
                    softWrap: false,
                  ),
                  Text(
                    '2000 جنيه',
                    style: TextStyles.font14BoldBlack,
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
                    style: TextStyles.font14BoldBlack,
                    textAlign: TextAlign.right,
                    softWrap: false,
                  ),
                  Text(
                    '2000 جنيه',
                    style: TextStyles.font14BoldBlack,
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
                    style: TextStyles.font14BoldBlack,
                    textAlign: TextAlign.right,
                    softWrap: false,
                  ),
                  Text(
                    '2000 جنيه',
                    style: TextStyles.font14BoldBlack,
                    textAlign: TextAlign.right,
                    softWrap: false,
                  ),
                ],
              ),
              SizedBox(height: 26),
              OrangeBtn(
                title: "اتمام الطلب",
                onTap: onCompleteOrderTapped ?? () {},
              ),
              SizedBox(height: 26),
            ],
          ),
        )
      ],
    );
  }
}

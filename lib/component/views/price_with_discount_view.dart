import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class PriceWithDiscountView extends GetView {
  final String price;
  final bool hasDiscount;
  final String? oldPrice;
  const PriceWithDiscountView({
    Key? key,
    required this.price,
    required this.hasDiscount,
    this.oldPrice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: <Widget>[
            Text(
              price,
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xFF1F1F1F),
                fontWeight: FontWeight.w500,
                height: 1.46,
              ),
              textAlign: TextAlign.right,
            ),
            Text(
              'ر.س',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF1F1F1F),
                fontWeight: FontWeight.w500,
                height: 1.58,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        AppSpacers.width5,
        if (hasDiscount)
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Text(
                    oldPrice ?? '',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'ر.س',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 2,
                color: const Color(0xff959595),
              )
            ],
          )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_colors.dart';

class GiftCardPaymentSummaryView extends GetView {
  const GiftCardPaymentSummaryView({
    Key? key,
    required this.giftCost,
    required this.totalCost,
  }) : super(key: key);

  final String giftCost;
  final String totalCost;
  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'قيمة بطاقة الهدايا',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.blackColor,
                    height: 1.36,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  '$giftCost ر.س',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.blackColor,
                    height: 1.36,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'اجمالي المبلغ',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.mainColor,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  '$totalCost رس',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

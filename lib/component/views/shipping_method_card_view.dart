import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_radio_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ShippingMethodCardView extends GetView {
  const ShippingMethodCardView({
    Key? key,
    required this.cost,
    required this.name,
    required this.delivryTime,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String name;
  final String cost;
  final String delivryTime;
  final bool isSelected;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                  letterSpacing: 0.32,
                ),
                textAlign: TextAlign.right,
              ),
              AppSpacers.height12,
              Text(
                'الوقت المتوقع للتوصيل : $delivryTime أيام   |   السعر : $cost ر.س',
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppColors.greyColor,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Spacer(),
          CustomRadioView(
            isActive: isSelected,
          ),
        ],
      ),
    );
  }
}

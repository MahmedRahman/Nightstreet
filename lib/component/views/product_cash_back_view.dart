import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ProductCashBackView extends GetView {
  const ProductCashBackView({
    Key? key,
    required this.cashBackValue,
  }) : super(key: key);

  final String cashBackValue;
  @override
  Widget build(BuildContext context) {
    if (cashBackValue == 0) return SizedBox();
    return DottedBorder(
      dashPattern: [4, 3],
      color: AppColors.mainColor,
      borderType: BorderType.RRect,
      radius: Radius.circular(6),
      strokeWidth: 1,
      child: Container(
        height: 44,
        color: AppColors.mainColor.withOpacity(.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppSvgAssets.offersIcon),
            AppSpacers.width10,
            Text(
              'كاش باك $cashBackValue ريال سعودي',
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 14.0,
                color: AppColors.mainColor,
                letterSpacing: 0.21,
                height: 1.64,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

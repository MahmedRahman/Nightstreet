import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class OrderInfoCardView extends GetView {
  const OrderInfoCardView({
    Key? key,
    required this.orderDate,
    required this.orderNo,
    required this.status,
  }) : super(key: key);

  final String orderNo;
  final String orderDate;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'رقم الطلب : $orderNo',
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.blackColor,
                letterSpacing: 0.48,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacers.height19,
            Text(
              'تاريخ الطلب : $orderDate',
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.greyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Spacer(),
        orderStatusCard(status: status),
      ],
    );
  }

  Container orderStatusCard({required String status}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: getColorBasedOnStatus(status).withOpacity(0.08),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppSvgAssets.orderStatusBox,
            color: getColorBasedOnStatus(status),
          ),
          AppSpacers.width5,
          Text(
            status,
            style: TextStyle(
              fontSize: 14.0,
              color: getColorBasedOnStatus(status),
              height: 0.86,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Color getColorBasedOnStatus(String status) {
    switch (status) {
      case "تم التوصيل":
        return AppColors.greenColor;
      case "قيد التوصيل":
        return AppColors.orangeColor;
      case "ملغى":
        return AppColors.errorColor;
      default:
        return AppColors.mainColor;
    }
  }
}

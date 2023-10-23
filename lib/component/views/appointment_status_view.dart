import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class AppointmentStatusView extends GetView {
  const AppointmentStatusView({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: getColorBasedOnStatus(status).withOpacity(0.08),
        border: Border.all(
          width: 0.7,
          color: getColorBasedOnStatus(status),
        ),
      ),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            fontSize: 14.0,
            color: getColorBasedOnStatus(status),
            letterSpacing: 0.14,
            height: 0.86,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Color getColorBasedOnStatus(String status) {
    switch (status) {
      case "مكتمل":
      case "تمت الموافقه":
        return AppColors.greenColor;
      case "عدم الحضور":
      case "بانتظار الموافقه":
        return AppColors.orangeColor;
      case "ملغى":
        return AppColors.errorColor;
      default:
        return AppColors.mainColor;
    }
  }
}

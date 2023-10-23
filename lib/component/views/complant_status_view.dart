import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class ComplantStatusView extends GetView {
  const ComplantStatusView({
    Key? key,
    required this.isActiveComplaint,
        required this.statusTitle,

  }) : super(key: key);

  final bool isActiveComplaint;
    final String statusTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.15, 0.0),
      width: 60.0,
      height: 26.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: (isActiveComplaint ? AppColors.greenColor : AppColors.errorColor)
            .withOpacity(0.08),
        border: Border.all(
          width: 0.7,
          color:
              (isActiveComplaint ? AppColors.greenColor : AppColors.errorColor),
        ),
      ),
      child: Text(
        statusTitle,
        style: TextStyle(
          fontSize: 14.0,
          color:
              isActiveComplaint ? AppColors.greenColor : AppColors.errorColor,
          letterSpacing: 0.14,
          height: 0.86,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class CustomRadioView extends GetView {
  const CustomRadioView({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.center,
      width: 14.0,
      height: 14.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.0,
          color: AppColors.mainColor,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.mainColor : Colors.transparent,
        ),
      ),
    );
  }
}

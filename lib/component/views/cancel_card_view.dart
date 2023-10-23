import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class CancelCardView extends GetView {
  const CancelCardView({
    Key? key,
    required this.isSelected,
    required this.reason,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String reason;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: isSelected ? AppColors.mainColor : Colors.transparent,
                  border: Border.all(
                    width: 1.0,
                    color: AppColors.greyColor.withOpacity(0.4),
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      )
                    : SizedBox.shrink(),
              ),
              AppSpacers.width10,
              Text(
                reason,
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.greyColor,
                  letterSpacing: 0.24,
                  height: 0.75,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

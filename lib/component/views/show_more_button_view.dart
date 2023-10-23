import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ShowMoreButtonView extends GetView {
  final VoidCallback onShowMoreTapped;
  final String title;
  const ShowMoreButtonView({
    Key? key,
    required this.onShowMoreTapped,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.48,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        ),
        InkWell(
          onTap: onShowMoreTapped,
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          child: Container(
            width: 80.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: const Color(0xFFFBFBFB),
              border: Border.all(
                width: 1.0,
                color: AppColors.borderColor2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'عرض الكل',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.mainColor,
                    height: 0.86,
                  ),
                  textAlign: TextAlign.right,
                ),
                AppSpacers.width5,
                SvgPicture.asset(AppSvgAssets.arrowIcon)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ComplantAddAttachmentBtnView extends GetView {
  const ComplantAddAttachmentBtnView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        height: 66,
        width: Get.width,
        decoration: BoxDecoration(
          color: Color(0xffF5F6F9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: DottedBorder(
          dashPattern: [4, 3],
          color: AppColors.mainColor,
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          padding: EdgeInsets.all(6),
          strokeWidth: 1,
          child: Container(
            height: 66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(AppSvgAssets.arrowCircleUpIcon),
                AppSpacers.width10,
                Text(
                  'ارفق صورة أو ملف',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.blackColor,
                    letterSpacing: 0.21,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

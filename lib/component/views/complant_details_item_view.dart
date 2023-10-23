import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/extensions/date_time.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ComplantDetailsItemView extends GetView {
  const ComplantDetailsItemView({
    Key? key,
    required this.isLoggedInUser,
    required this.messageTime,
    required this.message,
  }) : super(key: key);

  final bool isLoggedInUser;
  final DateTime messageTime;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isLoggedInUser ? AppColors.greyColor4 : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: isLoggedInUser ? Colors.grey : Colors.green,
                child: isLoggedInUser
                    ? Icon(
                        Icons.person_2,
                        color: Colors.white,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          "assets/image/launcher.png",
                        ),
                      ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLoggedInUser ? 'أنت' : 'كرز',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.blackColor,
                      letterSpacing: 0.14,
                      height: 0.86,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  AppSpacers.height5,
                  Row(
                    children: [
                      SvgPicture.asset(AppSvgAssets.clockIcon),
                      AppSpacers.width5,
                      Text(
                        '${messageTime.getArabicRelativeTimeString()}  ${messageTime.formatToArabicTime()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.greyColor,
                          letterSpacing: 0.12,
                          height: 1.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      AppSpacers.width5,
                    ],
                  ),
                ],
              ),
            ],
          ),
          AppSpacers.height5,
          Container(
            width: Get.width,
            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * .8),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.greyColor,
                height: 1.86,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

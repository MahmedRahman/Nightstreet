import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:krzv2/utils/app_colors.dart';
import 'package:store_redirect/store_redirect.dart';

Future<dynamic> updateDialog() {
  return Get.defaultDialog(
    onWillPop: () {
      exit(0);
    },
    titlePadding: EdgeInsets.all(20),
    title: "available_version".tr,
    backgroundColor: Colors.white,
    titleStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.mainColor,
      height: 1.2,
    ),
    radius: 11,
    content: Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'قم بتحديث التطبيق الآن، للاستفادة من كافة مميزات التطبيق',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
          Container(
            width: 800,
            height: 2,
            color: AppColors.greyColor2,
          ).paddingOnly(top: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                child: Text(
                  'تحديث',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
                onTap: () {
                  StoreRedirect.redirect(
                    androidAppId: "com.krz.app",
                    iOSAppId: "6445977887",
                  );
                },
              ),
              InkWell(
                child: Text(
                  'الغاء',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                onTap: () => exit(0),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

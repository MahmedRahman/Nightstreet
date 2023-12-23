import 'package:app_night_street/app/modules/login/views/login_view.dart';
import 'package:app_night_street/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FontWeightHelper {
  static const FontWeight regular = FontWeight.normal;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.bold;
}

class TextStyles {
  static TextStyle font14BoldOrange = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeightHelper.bold,
    color: AppColor.KOrangeColor,
  );
  static TextStyle font14BoldBlack = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );
  static TextStyle font13mediumBlack = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeightHelper.medium,
    color: AppColor.KBlackColor,
  );
  static TextStyle font13boldBlack = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeightHelper.bold,
    color: AppColor.KBlackColor,
  );
  static TextStyle font13regularBlack = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.KBlackColor,
  );
  static TextStyle font16regularBlack2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.KBlackColor2,
  );
  static TextStyle font13regularGray = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.KgrayColor,
  );
  static TextStyle font17boldBlack = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeightHelper.bold,
    color: AppColor.KBlackColor,
  );
  static TextStyle font14mediumBlack = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeightHelper.medium,
    color: AppColor.KBlackColor,
  );
  static TextStyle font12regularGray = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.KgrayColor,
  );
  static TextStyle font12regularBlack = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );
}

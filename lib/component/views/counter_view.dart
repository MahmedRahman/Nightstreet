import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class CounterView extends GetView {
  const CounterView({
    Key? key,
    required this.onDecrementTapped,
    required this.onIncrementTapped,
    this.width,
    this.height,
    this.borderRadius,
    this.numberTextStyle,
    this.verticalDividerIndent = 13,
    this.verticalDividerEndIndent = 13,
    this.initValue = 1,
  }) : super(key: key);

  final GestureTapCallback? onIncrementTapped;
  final GestureTapCallback? onDecrementTapped;
  final double? width;
  final double? height;
  final double? borderRadius;
  final TextStyle? numberTextStyle;
  final double? verticalDividerIndent;
  final double? verticalDividerEndIndent;
  final num initValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      width: width ?? null,
      decoration: BoxDecoration(
        color: AppColors.greyColor4,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 0),
        ),
        border: Border.all(color: AppColors.borderColor2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppSpacers.width5,
          GestureDetector(
            child: Icon(
              Icons.add,
              color: AppColors.greyColor,
              size: 20,
            ),
            onTap: onIncrementTapped,
          ),
          VerticalDivider(
            indent: verticalDividerIndent,
            endIndent: verticalDividerEndIndent,
            thickness: 2,
            color: AppColors.borderColor2,
          ),
          Text(
            initValue.toString(),
            style: TextStyle(
              fontSize: 16.0,
              color: const Color(0xFF313131),
              fontWeight: FontWeight.w700,
              height: 0.75,
            ),
            textAlign: TextAlign.center,
          ),
          VerticalDivider(
            indent: verticalDividerIndent,
            endIndent: verticalDividerEndIndent,
            thickness: 2,
            color: AppColors.borderColor2,
          ),
          GestureDetector(
            child: Icon(
              Icons.remove,
              color: AppColors.greyColor,
              size: 20,
            ),
            onTap: onDecrementTapped,
          ),
          AppSpacers.width5,
        ],
      ),
    );
  }
}

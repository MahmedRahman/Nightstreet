import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class CustomCheckView extends GetView {
  const CustomCheckView(
      {Key? key,
      required this.backgroundColor,
      required this.iconColor,
      this.radius = 10})
      : super(key: key);

  final Color iconColor;
  final double radius;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: SvgPicture.asset(
        AppSvgAssets.checkIcon,
        width: 8,
        height: 8,
        color: iconColor,
      ),
      backgroundColor: backgroundColor,
    );
  }
}

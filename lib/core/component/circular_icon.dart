import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CircularIcon extends GetView {
  const CircularIcon({
    super.key,
    required this.iconPath,
    required this.onTap,
  });
  final String iconPath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: const Color(0xfff8f5f5),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              iconPath,
            ),
          ),
        ));
  }
}

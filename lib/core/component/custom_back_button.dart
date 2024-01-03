import 'package:app_night_street/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onBackTapped,
    this.backGroundColor = Colors.white,
  });

  final Function()? onBackTapped;
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBackTapped ?? () => Get.back(),
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          child: Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: backGroundColor ?? AppColor.KWhiteOpacity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                "images/svg/back_icon.svg",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

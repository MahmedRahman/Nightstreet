import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onBackTapped,
  });

  final Function()? onBackTapped;

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
              color: AppColors.greyColor2,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                AppSvgAssets.backIcon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ProductServiceButtonView extends GetView {
  final String title;
  final String icon;
  final VoidCallback onTap;

  ProductServiceButtonView({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  ProductServiceButtonView.product({
    super.key,
    required this.onTap,
  })  : title = "المنتجات",
        icon = AppSvgAssets.productIcon;

  ProductServiceButtonView.service({
    super.key,
    required this.onTap,
  })  : title = "الخدمات",
        icon = AppSvgAssets.serviceIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: context.width,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColors.greyColor4,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SvgPicture.asset(
                  icon,
                ),
              ),
            ),
            AppSpacers.height12,
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF1F1F1F),
                letterSpacing: 0.48,
                fontWeight: FontWeight.w500,
                height: 0.75,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

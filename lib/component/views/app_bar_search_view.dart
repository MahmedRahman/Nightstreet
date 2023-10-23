import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class AppBarSerechView extends GetView implements PreferredSizeWidget {
  AppBarSerechView({
    required this.placeHolder,
    required this.onTap,
    this.actions,
  });

  final String placeHolder;
  final List<Widget>? actions;
  final Function()? onTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.greyColor4,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderColor2),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  AppSvgAssets.searchIconIcon,
                ),
              ),
              AppSpacers.width10,
              Text(
                '$placeHolder',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: actions,
    );
  }
}

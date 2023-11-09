import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';

import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class CategoryCardView extends GetView {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;
  final bool? isSelected;
  const CategoryCardView({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    this.isSelected = false,
  });

  CategoryCardView.dummy({
    Key? key,
    this.onTap,
    this.isSelected,
  })  : this.title = 'title',
        this.imageUrl =
            'https://ipsf.net/wp-content/uploads/2021/12/dummy-image-square.webp';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        width: 72,
        margin: const EdgeInsets.only(left: 8),
        constraints: BoxConstraints(
          maxWidth: 72,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: (isSelected ?? false) ? AppColors.mainColor : Colors.white,
          border: Border.all(
            width: 1.0,
            color: AppColors.greyColor2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 6,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CashedNetworkImageView(
                height: 55,
                imageUrl: imageUrl,
              ),
              AppSpacers.height5,
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  color: (isSelected ?? false)
                      ? Colors.white
                      : AppColors.blackColor,
                  height: 0.86,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

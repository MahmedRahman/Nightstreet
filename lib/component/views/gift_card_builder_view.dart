import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/network_image_view.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';

class GiftCardBuilderView extends GetView {
  final bool isSelected;
  final String image;
  const GiftCardBuilderView({
    Key? key,
    required this.isSelected,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 108.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            border: Border.all(
              width: 1.0,
              color: AppColors.borderColor2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: NetworkImageView(
              imageUrl: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(8),
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? const Color(0xFFE6D1D9).withOpacity(0.4) : AppColors.borderColor2,
          ),
          child: SvgPicture.asset(
            AppSvgAssets.checkIcon,
            width: 8.1,
            height: 6.49,
            color: isSelected ? null : Color(0xff707070),
          ),
        ),
      ],
    );
  }
}

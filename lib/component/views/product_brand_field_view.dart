import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ProductBrandFieldView extends GetView {
  const ProductBrandFieldView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الماركات التجارية',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.blackColor,
            letterSpacing: 0.18,
            fontWeight: FontWeight.w500,
            height: 0.67,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height16,
        GestureDetector(
            onTap: () => Get.toNamed(Routes.COMMERCIAL_BRANDS),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: AppColors.greyColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اختر من القائمة',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.blackColor,
                      letterSpacing: 0.24,
                      height: 0.75,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ).paddingSymmetric(horizontal: 19),
            )),
        AppSpacers.height5,
        Wrap(
          spacing: 2,
          children: ['1', '2']
              .map(
                (brand) => Stack(
                  children: [
                    _brandNameBuilder('title'),
                    _removeIconBuider(onTap: () {}),
                  ],
                ),
              )
              .toList(),
        ),
        Divider(),
      ],
    );
  }

  Widget _removeIconBuider({required Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.mainColor,
        ),
        child: Icon(
          Icons.clear,
          size: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _brandNameBuilder(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1.0,
          color: AppColors.greyColor,
        ),
      ),
      child: Text(title),
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 2.5,
      ),
      margin: const EdgeInsets.all(7),
    );
  }
}

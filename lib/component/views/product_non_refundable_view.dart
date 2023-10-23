import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ProductNonRefundableView extends GetView {
  const ProductNonRefundableView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SvgPicture.asset(AppSvgAssets.nonRefandableIcon),
            AppSpacers.width10,
            Text(
              'لا يمكن استبدال أو إرجاع هذا المنتج',
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.blackColor,
                letterSpacing: 0.21,
                height: 0.86,
              ),
              textAlign: TextAlign.right,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.blackColor,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

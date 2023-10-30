import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class OrderCompleteAddressEmptyView extends GetView {
  const OrderCompleteAddressEmptyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'إتمام الطلب'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppPageEmpty.addressesList(
            description: 'لإستكمال الطلب يجب إضافة عنوان',
          ),
          AppSpacers.height25,
          addNewAddressBtn(
            onTap: () => Get.toNamed(Routes.ADD_NEW_ADDRESS),
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  Widget addNewAddressBtn({
    required Function() onTap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.end,
  }) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          SvgPicture.asset(AppSvgAssets.addIcon),
          AppSpacers.width5,
          Text(
            'عنوان جديد',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.blackColor,
              height: 0.86,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

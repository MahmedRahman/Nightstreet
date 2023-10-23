import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_service_view.dart';
import 'package:krzv2/component/views/app_bar.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/product_filter_bottom_sheet_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/service_filter_bottom_sheet_view.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/offer_list_controller.dart';

class OfferListView extends GetView<OfferListController> {
  int selectTab = 0;

  final authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: TitleSubtitleAppBar(
        titleText: 'استكشــف',
        subTitle: 'أقوى العروض',
        actions: [
          if (authController.isLoggedIn)
            CustomIconButton(
              onTap: () => Get.toNamed(Routes.SHOPPINT_CART),
              iconPath: AppSvgAssets.cartIcon,
              count: 2,
            ),
          CustomIconButton(
            onTap: () {
              Get.bottomSheet(
                selectTab == 0
                    ? ServiceFilterBottomSheetView()
                    : ProductFilterBottomSheetView(),
                backgroundColor: Colors.white,
                barrierColor: AppColors.mainColor.withOpacity(.15),
                ignoreSafeArea: true,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
              );
            },
            iconPath: AppSvgAssets.filterIcon,
            count: 0,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            AppSpacers.height16,
            BaseSwitchTap(
              title1: "الخدمات",
              title2: "المنتجات",
              Widget1: OfferServiceView(),
              Widget2: OfferProductView(),
              onTap: (index) {
                selectTab = index;
                log('onTap index $index');
                log('onTap selectTab $selectTab');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget bntIcon({
  //   required String assetName,
  //   required void Function()? onTap,
  // }) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       width: 38.0,
  //       height: 38.0,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         color: Color(0xffFAFAFA),
  //         border: Border.all(
  //           width: 1.0,
  //           color: Color(0xffF5F5F5),
  //         ),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(
  //           vertical: 8,
  //           horizontal: 8,
  //         ),
  //         child: SvgPicture.asset(
  //           assetName,
  //           width: 32,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/offer_list/controllers/offer_product_controller.dart';
import 'package:krzv2/app/modules/offer_list/controllers/offer_service_controller.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_service_view.dart';
import 'package:krzv2/component/views/app_bar.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/product_filter_bottom_sheet_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/service_filter_bottom_sheet_view.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/offer_list_controller.dart';

class OfferListView extends GetView<OfferListController> {
  int selectTab = 0;

  final authController = Get.find<AuthenticationController>();
  final offerProductController = Get.find<OfferProductController>();
  final offerServiceController = Get.find<OfferServiceController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: TitleSubtitleAppBar(
        titleText: 'استكشــف',
        subTitle: 'أقوى العروض',
        actions: [
          if (authController.isLoggedIn || authController.isGuestUser)
            ShoppingCartIconView(),
          CustomIconButton(
            onTap: () {
              Get.bottomSheet(
                selectTab == 0
                    ? ServiceFilterBottomSheetView(
                        maxPrice: KOfferHighestPrice.value,
                        query: offerServiceController.filterQuery,
                        onChanged: offerServiceController.onFilterDataChanged,
                        onResetTapped: () {
                          offerServiceController.pagingController.value =
                              PagingController(firstPageKey: 1);

                          offerServiceController.pageListener();
                        },
                      )
                    : ProductFilterBottomSheetView(
                        onChanged: offerProductController.onFilterDataChanged,
                        productQuery: offerProductController.queryParams,
                        maxPrice: KProductHighestPrice.value,
                        onResetTapped: () {
                          offerServiceController.pagingController.value =
                              PagingController(firstPageKey: 1);

                          offerServiceController.pageListener();
                        },
                      ),
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
}

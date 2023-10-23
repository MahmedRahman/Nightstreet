import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/custom_tab_bar_view.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/product_filter_bottom_sheet_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/utils/app_colors.dart';

import '../controllers/products_list_controller.dart';

class ProductsListView extends GetView<ProductsListController> {
  ProductsListView({Key? key}) : super(key: key);

  final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
  final double itemWidth = Get.width / 2;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'البشرة',
        actions: [
          CustomIconButton(
            onTap: () => Get.toNamed(Routes.SHOPPINT_CART),
            iconPath: AppSvgAssets.cartIcon,
            count: 2,
          ),
          CustomIconButton(
            onTap: () {
              Get.bottomSheet(
                ProductFilterBottomSheetView(
                  showDropDown: false,
                ),
                backgroundColor: Colors.white,
                barrierColor: AppColors.mainColor.withOpacity(.15),
                ignoreSafeArea: true,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
              );
            },
            iconPath: AppSvgAssets.filterIcon,
            count: 0,
          ),
          SizedBox(width: 20),
        ],
      ),
      body: controller.obx(
        (state) => Padding(
          padding: AppDimension.appPadding,
          child: RefreshIndicator(
            color: AppColors.mainColor,
            onRefresh: () async {},
            child: CustomTabBarView(
                tabTitles: controller.categories,
                tabContent: controller.categories
                    .map(
                      (e) => GridView.builder(
                        padding: EdgeInsets.only(top: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (itemWidth / itemHeight) / .42,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (_, index) {
                          return ProductCardView.dummy();
                        },
                      ),
                    )
                    .toList()),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shipping_item_view.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/shoppint_cart_controller.dart';

class ShoppingCartView extends GetView<ShoppintCartController> {
  const ShoppingCartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'سلة الشراء',
      ),
      // body: AppPageEmpty.shoppingCart(),
      body: ListView.builder(
        padding: AppDimension.appPadding,
        itemBuilder: (context, index) {
          return ShippingItemView.demmy();
        },
      ),
      bottomBarHeight: 190,
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'مجموع المنتجات (5)',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                    letterSpacing: 0.16,
                    fontWeight: FontWeight.w500,
                    height: 2.19,
                  ),
                  textAlign: TextAlign.right,
                ),
                Spacer(),
                Text(
                  '1760 ر.س',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                    height: 1.19,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            AppSpacers.height12,
            CustomBtnCompenent.main(
              text: "استكمل عملية الشراء",
              onTap: () => Get.toNamed(Routes.ORDER_COMPLETE),
            ),
          ],
        ),
      ),
    );
  }
}

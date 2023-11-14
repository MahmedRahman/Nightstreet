import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/market_component_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shipping_item_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';

import '../controllers/shopping_cart_controller.dart';

class ShoppingCartView extends GetView<ShoppingCartController> {
  const ShoppingCartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (products) {
        return BaseScaffold(
          onRefresh: () async => controller.onInit(),
          appBar: CustomAppBar(
            titleText: 'سلة الشراء',
          ),
          body: controller.obx(
            (markets) {
              return ListView.builder(
                padding: AppDimension.appPadding,
                itemCount: markets!.length,
                itemBuilder: (context, index) {
                  final market = markets.elementAt(index);
                  final products = market.products;
                  return MarketComponentView(
                    market: market,
                    products: products,
                  );
                },
              );
            },
          ),
        );
      },
      onEmpty: onEmpty(),
      onLoading: onLoading(),
    );
  }

  BaseScaffold onEmpty() {
    return BaseScaffold(
      onRefresh: () async => controller.onInit(),
      appBar: CustomAppBar(
        titleText: 'سلة الشراء',
      ),
      body: AppPageEmpty.shoppingCart(),
    );
  }

  BaseScaffold onLoading() {
    return BaseScaffold(
      onRefresh: () async => controller.onInit(),
      appBar: CustomAppBar(
        titleText: 'سلة الشراء',
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.greyColor4.withOpacity(0.7),
          border: Border.all(
            width: 1.0,
            color: AppColors.borderColor2,
          ),
        ),
        child: ListView.builder(
          padding: AppDimension.appPadding,
          itemCount: 4,
          itemBuilder: (context, index) {
            return ShippingItemView.demmy().shimmer();
          },
        ),
      ),
    );
  }

  Row summary({
    required String cartCount,
    required String total,
  }) {
    return Row(
      children: [
        Text(
          'مجموع المنتجات ($cartCount)',
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
          '$total ر.س',
          style: TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
            height: 1.19,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

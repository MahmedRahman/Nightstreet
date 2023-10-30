import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shipping_item_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/shoppint_cart_controller.dart';

class ShoppingCartView extends GetView<ShoppintCartController> {
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
            (products) {
              return ListView.builder(
                padding: AppDimension.appPadding,
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  final product = products.elementAt(index);
                  return ShippingItemView(
                    image: product.productImage,
                    price: product.price.toString(),
                    name: product.productName,
                    oldPrice: product.oldPrice.toString(),
                    amount: product.quantity.toString(),
                    onDeleteTapped: () => controller.deleteItemFromCart(
                      productId: product.cartItemId.toString(),
                    ),
                    onIncrement: () {
                      int newQuantity = product.quantity;
                      controller.addToCart(
                        isNew: false,
                        productId: product.productId.toString(),
                        quantity: '${++newQuantity}',
                        variantId: product.variantId == null
                            ? ''
                            : product.variantId.toString(),
                      );
                    },
                    ondecrement: () {
                      int newQuantity = product.quantity;
                      controller.addToCart(
                        isNew: false,
                        productId: product.productId.toString(),
                        quantity: '${--newQuantity}',
                        variantId: product.variantId == null
                            ? ''
                            : product.variantId.toString(),
                      );
                    },
                  );
                },
              );
            },
          ),
          bottomBarHeight: 190,
          bottomNavigationBar: Padding(
            padding: AppDimension.appPadding,
            child: Column(
              children: [
                summary(
                  cartCount:
                      controller.cartSummaryModel.value!.cartCount.toString(),
                  total: controller.cartSummaryModel.value!.cartTotalPrice,
                ),
                AppSpacers.height12,
                CustomBtnCompenent.main(
                  text: "استكمل عملية الشراء",
                  onTap: () => Get.toNamed(
                    Routes.ORDER_COMPLETE,
                    arguments: controller.cartSummaryModel.value,
                  ),
                ),
              ],
            ),
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
      body: ListView.builder(
        padding: AppDimension.appPadding,
        itemCount: 4,
        itemBuilder: (context, index) {
          return ShippingItemView.demmy().shimmer();
        },
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

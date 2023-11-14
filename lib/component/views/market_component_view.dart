import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/shipping_item_view.dart';
import 'package:krzv2/models/product_cart_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class MarketComponentView extends GetView {
  MarketComponentView({
    Key? key,
    required this.market,
    required this.products,
  }) : super(key: key);

  final MarketShippingCart market;
  final List<ProductCartModel> products;

  final cartController = Get.find<ShoppingCartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.0,
          color: AppColors.borderColor2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              bottom: 10,
            ),
            child: Row(
              children: [
                Text(
                  market.marketName,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  ' (${market.marketProductCount} منتج)',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: const Color(0xFFB1AFAF),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.greyColor4.withOpacity(0.7),
              border: Border.all(
                width: 1.0,
                color: AppColors.borderColor2,
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products.elementAt(index);
                final isLastIndex = products.length - 1 == index;
                return Column(
                  children: [
                    ShippingItemView(
                      image: product.productImage,
                      price: product.price.toString(),
                      name: product.productName,
                      oldPrice: product.oldPrice.toString(),
                      amount: product.quantity.toString(),
                      onDeleteTapped: () {
                        if (Get.find<AuthenticationController>().isGuestUser) {
                          cartController.deleteGuestProductCart(
                            productId: product.cartItemId.toString(),
                          );
                          return;
                        }
                        cartController.deleteItemFromCart(
                          productId: product.cartItemId.toString(),
                        );
                      },
                      onIncrement: () {
                        int newQuantity = product.quantity;

                        if (Get.find<AuthenticationController>().isGuestUser) {
                          cartController.addToGuestCart(
                            isNew: false,
                            productId: product.productId.toString(),
                            quantity: '${++newQuantity}',
                            variantId: product.variantId == null
                                ? ''
                                : product.variantId.toString(),
                          );
                          return;
                        }

                        cartController.addToCart(
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

                        if (Get.find<AuthenticationController>().isGuestUser) {
                          cartController.addToGuestCart(
                            isNew: false,
                            productId: product.productId.toString(),
                            quantity: '${++newQuantity}',
                            variantId: product.variantId == null
                                ? ''
                                : product.variantId.toString(),
                          );
                          return;
                        }

                        cartController.addToCart(
                          isNew: false,
                          productId: product.productId.toString(),
                          quantity: '${--newQuantity}',
                          variantId: product.variantId == null
                              ? ''
                              : product.variantId.toString(),
                        );
                      },
                      onTap: () {
                        Get.toNamed(
                          Routes.PRODUCT_DETAILS,
                          arguments: product.productId.toString(),
                        );
                      },
                    ),
                    if (isLastIndex == false)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: DottedLine(
                          dashLength: 10,
                          dashGapLength: 5,
                          lineThickness: 2,
                          dashColor: AppColors.borderColor2,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          AppSpacers.height12,
          Row(
            children: [
              Expanded(
                child: CustomBtnCompenent.main(
                  text: "كمل طلبك",
                  onTap: () async {
                    if (Get.find<AuthenticationController>().isGuestUser) {
                      AppDialogs.showToast(
                        message: 'الرجاء تسجيل الدخول لإستكمل الطلب',
                      );
                      Get.toNamed(Routes.LOGIN);
                      return;
                    }
                    cartController.selectedMarketId.value =
                        market.marketId.toString();
                    Get.toNamed(
                      Routes.ORDER_COMPLETE,
                    );
                  },
                ),
              ),
              AppSpacers.width10,
              Expanded(
                child: CustomBtnCompenent.secondary(
                  text: "إضافة منتج",
                  onTap: () async {},
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

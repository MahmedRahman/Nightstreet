import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/show_more_button_view.dart';
import 'package:krzv2/models/product_model.dart';

import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ProductsHotizontalListView extends GetView {
  final List<ProductModel> productsList;

  final String showMoreText;
  final VoidCallback onShowMoreTapped;
  final Function(ProductModel product)? onAddToCartTapped;
  final Function(int productId)? onFavoriteTapped;
  final Function(int productId)? onTap;

  const ProductsHotizontalListView({
    Key? key,
    required this.productsList,
    required this.showMoreText,
    required this.onShowMoreTapped,
    required this.onAddToCartTapped,
    required this.onFavoriteTapped,
    required this.onTap,
  }) : super(key: key);

  const ProductsHotizontalListView.recommended({
    Key? key,
    required this.productsList,
    required this.onShowMoreTapped,
    required this.onAddToCartTapped,
    required this.onFavoriteTapped,
    required this.onTap,
  })  : showMoreText = 'منتجات قد تعجبك',
        super(key: key);

  const ProductsHotizontalListView.mostWanted({
    Key? key,
    required this.productsList,
    required this.onShowMoreTapped,
    this.onAddToCartTapped,
    this.onFavoriteTapped,
    this.onTap,
  })  : showMoreText = "الأكثر طلبا",
        super(key: key);

  const ProductsHotizontalListView.exclusiveOffers({
    Key? key,
    required this.productsList,
    required this.onShowMoreTapped,
    this.onAddToCartTapped,
    this.onFavoriteTapped,
    this.onTap,
  })  : showMoreText = "العروض الحصرية",
        super(key: key);

  const ProductsHotizontalListView.similarproducts({
    Key? key,
    required this.productsList,
    required this.onShowMoreTapped,
    this.onAddToCartTapped,
    this.onFavoriteTapped,
    this.onTap,
  })  : showMoreText = "منتجات المشابهة",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowMoreButtonView(
          onShowMoreTapped: onShowMoreTapped,
          title: showMoreText,
        ),
        AppSpacers.height16,
        SizedBox(
          height: 255,
          child: ListView.builder(
            itemCount: productsList.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemBuilder: (context, index) {
              final product = productsList.elementAt(index);
              return GetBuilder<ProductFavoriteController>(
                init: ProductFavoriteController(),
                builder: (
                  ProductFavoriteController controller,
                ) {
                  return ProductCardView(
                    imageUrl: product.image,
                    name: product.name,
                    hasDiscount: product.oldPrice.toInt() != 0,
                    oldPrice: product.oldPrice.toString(),
                    price: product.price.toString(),
                    onAddToCartTapped: () => onAddToCartTapped!(product),
                    onFavoriteTapped: () {
                      if (Get.put(AuthenticationController().isLoggedIn) ==
                          false) {
                        return AppDialogs.showToast(
                            message: 'الرجاء تسجيل الدخول');
                      }
                      onFavoriteTapped!(product.id);
                    },
                    isFavorite: controller.productFavoriteIds.value!
                        .contains(product.id),
                    isLimitedQuantity: product.quantity < 10,
                    isAvailable: product.quantity > 1,
                    onTap: () => onTap!(product.id),
                  ).paddingOnly(left: 8);
                },
              );
            },
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_products_slider_controller.dart';
import 'package:krzv2/app/modules/offer_list/controllers/offer_product_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_categories_list_view.dart';
import 'package:krzv2/component/views/pages/app_page_loading_more.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_spacers.dart';

RxInt KProductHighestPrice = 0.obs;

class OfferProductView extends GetView<OfferProductController> {
  OfferProductView({Key? key}) : super(key: key);
  final cartController = Get.find<ShoppingCartController>();
  final sliderController = Get.find<HomePageProductSliderController>();
  final productCategoriesController = Get.find<ProductCategoriesController>();

  @override
  Widget build(BuildContext context) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
    final double itemWidth = Get.width / 2;

    return Scaffold(
      body: Column(
        children: [
          sliderController.obx(
            (slidersList) {
              return SliderView(
                images: slidersList!.map((slider) => slider.image).toList(),
              );
            },
            onLoading: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
            ).shimmer(),
          ),
          AppSpacers.height16,
          productCategoriesController.obx(
            (categoriesList) {
              return HomeCategoriesListView(
                categoriesList: categoriesList,
                onCategoryTapped: (int categoryId) async {
                  await Get.toNamed(
                    Routes.PRODUCTS_LIST,
                    arguments: categoryId.toString(),
                  );
                },
              );
            },
            onLoading: HomeCategoriesListView(
              categoriesList: [],
              onCategoryTapped: (int categoryId) {
                Get.toNamed(Routes.PRODUCTS_LIST);
              },
            ).shimmer(),
          ),
          AppSpacers.height16,
          Expanded(
            child: controller.obx((List<ProductModel>? products) {
              return GridView.builder(
                padding: EdgeInsets.only(top: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight) / .35,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: products!.length,
                itemBuilder: (_, index) {
                  return GetBuilder<ProductFavoriteController>(
                    init: ProductFavoriteController(),
                    builder: (favoriteController) {
                      final product = products.elementAt(index);

                      if (index == products.length - 1 &&
                          products.length != 1) {
                        return AppPageLoadingMore(
                          display: controller.status.isLoadingMore,
                        );
                      }

                      return ProductCardView(
                        imageUrl: product.image.toString(),
                        name: product.name.toString(),
                        hasDiscount: product.oldPrice.toInt() != 0,
                        isAvailable: product.quantity > 1,
                        price: product.price.toString(),
                        oldPrice: product.oldPrice.toString(),
                        isFavorite:
                            favoriteController.productIsFavorite(product.id),
                        onAddToCartTapped: () {
                          if (product.variants.isNotEmpty) {
                            AppDialogs.showToast(
                              message:
                                  'هذا المنتج يحتوى على الوان يجب اختيار اللون',
                            );
                            Get.toNamed(
                              Routes.PRODUCT_DETAILS,
                              arguments: product.id.toString(),
                            );

                            return;
                          }

                          cartController.addToCart(
                            productId: product.id.toString(),
                            quantity: '1',
                            isNew: true,
                          );
                        },
                        onFavoriteTapped: () {
                          if (Get.find<AuthenticationController>().isLoggedIn ==
                              false) {
                            return AppDialogs.showToast(
                                message: 'الرجاء تسجيل الدخول');
                          }
                          final favCon = Get.put<ProductFavoriteController>(
                            ProductFavoriteController(),
                          );

                          favCon.addRemoveProductFromFavorite(
                            productId: product.id,
                          );
                        },
                        //, product.isFavorite,
                        onTap: () {
                          Get.toNamed(
                            Routes.PRODUCT_DETAILS,
                            arguments: product.id.toString(),
                          );
                        },
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_exclusive_offers_product_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_most_seller_product_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_products_slider_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/app_bar_search_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_banner_view.dart';
import 'package:krzv2/component/views/home_categories_list_view.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/products_hotizontal_list_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/home_page_products_controller.dart';

class HomePageProductsView extends GetView<HomePageProductsController> {
  HomePageProductsView({Key? key}) : super(key: key);

  final authController = Get.find<AuthenticationController>();
  final sliderController = Get.find<HomePageProductSliderController>();
  final productCategoriesController = Get.put(ProductCategoriesController());
  final mostSelleerProductController = Get.put(MostSelleerProductController());
  final cartController = Get.find<ShoppingCartController>();
  final exclusiveOffersProductController =
      Get.put(ExclusiveOffersProductController());
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBarSerechView(
        placeHolder: 'ما الذي تريد البحث عنه ؟',
        actions: [
          if (authController.isLoggedIn || authController.isGuestUser)
            ShoppingCartIconView(),
          if (authController.isLoggedIn) NotificationIconView(),
          AppSpacers.width20,
        ],
        onTap: () async {
          final shoudRefresh = await Get.toNamed(Routes.PRODUCT_SEARCH);
          if (shoudRefresh != null) {
            mostSelleerProductController.onInit();
            exclusiveOffersProductController.onInit();
          }
        },
      ),
      // appBar: HomePageProductsAppBarView(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          AppSpacers.height10,
          Padding(
            padding: AppDimension.appPadding,
            child: sliderController.obx(
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
          ),
          AppSpacers.height16,
          productCategoriesController.obx(
            (categoriesList) {
              return HomeCategoriesListView(
                categoriesList: categoriesList,
                onCategoryTapped: (int categoryId) async {
                  final shoudRefresh = await Get.toNamed(
                    Routes.PRODUCTS_LIST,
                    arguments: categoryId.toString(),
                  );
                  if (shoudRefresh != null) {
                    mostSelleerProductController.onInit();
                    exclusiveOffersProductController.onInit();
                  }
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
          Padding(
            padding: AppDimension.appPadding,
            child: mostSelleerProductController.obx(
              (List<ProductModel>? productsList) {
                return ProductsHotizontalListView.mostWanted(
                  productsList: productsList ?? [],
                  onShowMoreTapped: () => Get.toNamed(Routes.PRODUCTS_LIST),
                  onAddToCartTapped: (ProductModel product) {
                    if (product.variants.isNotEmpty) {
                      AppDialogs.showToast(
                        message: 'هذا المنتج يحتوى على الوان يجب اختيار اللون',
                      );
                      Get.toNamed(
                        Routes.PRODUCT_DETAILS,
                        arguments: product.id.toString(),
                      );

                      return;
                    }
                    final isGuest =
                        Get.find<AuthenticationController>().isGuestUser;

                    if (isGuest) {
                      cartController.addToGuestCart(
                        productId: product.id.toString(),
                        quantity: '1',
                        isNew: true,
                      );
                      return;
                    }
                    cartController.addToCart(
                      productId: product.id.toString(),
                      quantity: '1',
                      isNew: true,
                    );
                  },
                  onFavoriteTapped: (int productId) {
                    if (Get.find<AuthenticationController>().isLoggedIn ==
                        false) {
                      return AppDialogs.showToast(
                          message: 'الرجاء تسجيل الدخول');
                    }

                    final favCon = Get.put<ProductFavoriteController>(
                      ProductFavoriteController(),
                    );

                    favCon.addRemoveProductFromFavorite(
                      productId: productId,
                    );
                  },
                  onTap: (int id) {
                    Get.toNamed(
                      Routes.PRODUCT_DETAILS,
                      arguments: id.toString(),
                    );
                  },
                );
              },
              onLoading: ProductsHotizontalListView.mostWanted(
                productsList: [
                  ProductModel.dummyProduct,
                ],
                onShowMoreTapped: () {},
                onAddToCartTapped: (_) {},
                onFavoriteTapped: (_) {},
              ).shimmer(),
            ),
          ),
          AppSpacers.height16,
          Padding(
            padding: AppDimension.appPadding,
            child: HomeBannerView(
              imageUrl: 'assets/image/dummy/offers.png',
            ),
          ),
          AppSpacers.height16,
          Padding(
            padding: AppDimension.appPadding,
            child: exclusiveOffersProductController.obx(
              (List<ProductModel>? productsList) {
                return ProductsHotizontalListView.exclusiveOffers(
                  productsList: productsList ?? [],
                  onTap: (int id) async {
                    final awaitId = await Get.toNamed(
                      Routes.PRODUCT_DETAILS,
                      arguments: id.toString(),
                    );

                    if (awaitId != null && awaitId != '') {
                      mostSelleerProductController.toggleFavorite(id);
                    }
                  },
                  onShowMoreTapped: () => Get.toNamed(Routes.PRODUCTS_LIST),
                  onAddToCartTapped: (ProductModel product) {
                    if (product.variants.isNotEmpty) {
                      AppDialogs.showToast(
                        message: 'هذا المنتج يحتوى على الوان يجب اختيار اللون',
                      );
                      Get.toNamed(
                        Routes.PRODUCT_DETAILS,
                        arguments: product.id.toString(),
                      );

                      return;
                    }
                    final isGuest =
                        Get.find<AuthenticationController>().isGuestUser;

                    if (isGuest) {
                      cartController.addToGuestCart(
                        productId: product.id.toString(),
                        quantity: '1',
                        isNew: true,
                      );
                      return;
                    }
                    cartController.addToCart(
                      productId: product.id.toString(),
                      quantity: '1',
                      isNew: true,
                    );
                  },
                  onFavoriteTapped: (int productId) {
                    if (Get.put(AuthenticationController().isLoggedIn) ==
                        false) {
                      return AppDialogs.showToast(
                          message: 'الرجاء تسجيل الدخول');
                    }
                    final favCon = Get.put<ProductFavoriteController>(
                      ProductFavoriteController(),
                    );

                    favCon.addRemoveProductFromFavorite(
                      productId: productId,
                      onError: () {
                        exclusiveOffersProductController
                            .toggleFavorite(productId);
                      },
                    );
                  },
                );
              },
              onLoading: ProductsHotizontalListView.exclusiveOffers(
                productsList: [
                  ProductModel.dummyProduct,
                ],
                onShowMoreTapped: () {},
                onAddToCartTapped: (_) {},
                onFavoriteTapped: (_) {},
              ).shimmer(),
            ),
          ),
          // AppSpacers.height16,
          // Padding(
          //   padding: AppDimension.appPadding,
          //   child: HomeBannerView(
          //     imageUrl: 'assets/image/dummy/offers.png',
          //   ),
          // ),
          // AppSpacers.height16,
          // Padding(
          //   padding: AppDimension.appPadding,
          //   child: ProductsHotizontalListView(
          //     showMoreText: 'البشرة',
          //     productsList: [
          //       ProductModel.dummyProduct,
          //       ProductModel.dummyProduct,
          //       ProductModel.dummyProduct,
          //     ],
          //     onShowMoreTapped: () => Get.toNamed(Routes.PRODUCTS_LIST),
          //     onAddToCartTapped: (int productId) {},
          //     onFavoriteTapped: (int productId) {},
          //   ),
          // ),
          AppSpacers.height50,
        ],
      ),
    );
  }
}

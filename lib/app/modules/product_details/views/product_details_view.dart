import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/product_details/controllers/similar_product_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/counter_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_tap_bar.dart';
import 'package:krzv2/component/views/favorite_icon_view.dart';
import 'package:krzv2/component/views/image_swpier_view.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/on_product_loading_view.dart';
import 'package:krzv2/component/views/price_with_discount_view.dart';
import 'package:krzv2/component/views/product_brand_image_view.dart';
import 'package:krzv2/component/views/product_cash_back_view.dart';
import 'package:krzv2/component/views/product_color_selector_view.dart';
import 'package:krzv2/component/views/product_non_refundable_view.dart';
import 'package:krzv2/component/views/product_reviews_view.dart';
import 'package:krzv2/component/views/products_hotizontal_list_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/share_icon_view.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/product_details_controller.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({Key? key}) : super(key: key);
  final similarProductController = Get.put(SimilarProductController());
  final controller = Get.put(ProductDetailsController());
  final authController = Get.put(AuthenticationController());
  final cartController = Get.find<ShoppingCartController>();

  void customInit() {
    controller.fetchProductDetails(productId: Get.arguments as String);
  }

  final RxString variantId = ''.obs;

  @override
  Widget build(BuildContext context) {
    customInit();
    return controller.obx(
      (product) => buildBody(product),
      onLoading: OnProductLoadingView(),
      onError: (String? error) => Center(
        child: Text(
          error.toString(),
        ),
      ),
    );
  }

  BaseScaffold buildBody(ProductModel? product) {
    final similarProductController = Get.find<SimilarProductController>();

    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'تفاصيل المنتج',
        onBackTapped: () => Get.back(result: true),
        actions: [
          if (authController.isLoggedIn || authController.isGuestUser) ShoppingCartIconView(),
          if (authController.isLoggedIn) NotificationIconView(),
          SizedBox(width: 20),
        ],
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height12,
          ImageSwpierView(
            width: 200,
            height: 200,
            images: product!.images.map((e) => e.image).toList(),
          ),
          AppSpacers.height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductBrandImageView(
                imageUrl: product.brand.image,
              ),
              Row(
                children: [
                  FavoriteIconView(
                    onFavoriteTapped: () {
                      if (Get.find<AuthenticationController>().isLoggedIn == false) {
                        return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
                      }
                      final favCon = Get.put<ProductFavoriteController>(
                        ProductFavoriteController(),
                      );
                      product.isFavorite = !product.isFavorite;

                      favCon.addRemoveProductFromFavorite(
                        productId: product.id,
                        onError: () {
                          product.isFavorite = !product.isFavorite;
                        },
                      );

                      controller.update();
                    },
                    isFavorite: product.isFavorite,
                  ),
                  AppSpacers.width10,
                  ShareIconView(
                    onShareTapped: () {
                      Share.share(
                        'https://krz.sa/products/${product.id}',
                        subject: product.name,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          AppSpacers.height5,
          Divider(),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
              letterSpacing: 0.020799999237060548,
              height: 2.19,
            ),
            textAlign: TextAlign.right,
          ),
          AppSpacers.height16,
          Row(
            children: [
              PriceWithDiscountView(
                price: product.price.toString(),
                hasDiscount: product.oldPrice.toInt().toString() != '0',
                oldPrice: product.oldPrice.toString(),
              ),
              AppSpacers.width10,
              RatingBarView(
                initRating: product.totalRateCount,
                totalRate: product.totalRateAvg,
                ignoreGestures: true,
              ),
            ],
          ),
          AppSpacers.height16,
          ProductCashBackView(cashBackValue: product.cashback),
          AppSpacers.height10,
          ProductColorSelectorView(
            onChanged: (String id) {
              variantId.value = id;
            },
            variants: product.variants,
          ),
          AppSpacers.height12,
          ProductNonRefundableView(),
          AppSpacers.height5,
          Divider(),
          AppSpacers.height12,
          CustomTapBar(
            label1: 'وصف المنتج',
            label2: 'طريقة الاستعمال',
            label3: 'التقييمات',
            widget1: SingleChildScrollView(
              child: Html(
                data: product.desc,
              ),
            ),
            widget2: SingleChildScrollView(
              child: Html(
                data: product.usage,
              ),
            ),
            widget3: SizedBox(
              height: 400,
              child: ProductReviewsView(),
            ),
          ),
          AppSpacers.height16,
          Divider(),
          AppSpacers.height16,
          similarProductController.obx(
            (products) => ProductsHotizontalListView.similarproducts(
              productsList: products ?? [],
              onTap: (int productId) async {
                //AppDialogs.showToast(message: "message");

                controller.fetchProductDetails(productId: productId.toString());
                Get.toNamed(
                  Routes.PRODUCT_DETAILS,
                  arguments: productId.toString(),
                );
                // final awaitId = await

                // if (awaitId != null && awaitId != '') {
                //   similarProductController.toggleFavorite(productId);
                // }
              },
              onShowMoreTapped: () async {
                final shoudRefresh = await Get.toNamed(
                  Routes.PRODUCTS_LIST,
                  arguments: product.categories.first.id.toString(),
                );
                if (shoudRefresh != null) {
                  similarProductController.onInit();
                }
              },
              onAddToCartTapped: (ProductModel product) {
                final isGuest = Get.find<AuthenticationController>().isGuestUser;

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
                if (Get.find<AuthenticationController>().isLoggedIn == false) {
                  return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
                }
                final favCon = Get.put<ProductFavoriteController>(
                  ProductFavoriteController(),
                );
                similarProductController.toggleFavorite(productId);

                favCon.addRemoveProductFromFavorite(
                  productId: productId,
                  onError: () {
                    similarProductController.toggleFavorite(productId);
                  },
                );
              },
            ),
            onLoading: ProductsHotizontalListView.similarproducts(
              productsList: [
                ProductModel.dummyProduct,
              ],
              onShowMoreTapped: () {},
            ).shimmer(),
            onEmpty: SizedBox(),
          ),
          AppSpacers.height50,
        ],
      ),
      bottomBarHeight: 163,
      bottomNavigationBar: bottomNavigationBar(
        controller: controller,
        isAvailable: product.quantity > 1,
        productQuantity: product.quantity,
        onAddToCart: () {
          final cartController = Get.put<ShoppingCartController>(
            ShoppingCartController(),
          );

          final isGuest = Get.find<AuthenticationController>().isGuestUser;

          if (product.variants.isNotEmpty && variantId == '') {
            AppDialogs.showToast(message: 'الرجاء تحديد اللون');
            return;
          }

          if (isGuest) {
            cartController.addToGuestCart(
              productId: product.id.toString(),
              quantity: controller.productCount.value.toString(),
              variantId: variantId.value,
              isNew: true,
            );
            return;
          }

          cartController.addToCart(
            productId: product.id.toString(),
            quantity: controller.productCount.value.toString(),
            variantId: variantId.value,
            isNew: true,
          );
        },
      ),
    );
  }

  Padding bottomNavigationBar({
    required ProductDetailsController controller,
    required int productQuantity,
    required bool isAvailable,
    required Function() onAddToCart,
  }) {
    return Padding(
      padding: AppDimension.appPadding + EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => CounterView(
                width: 135,
                height: 53,
                borderRadius: 10,
                initValue: controller.productCount.value,
                onDecrementTapped: controller.decrement,
                onIncrementTapped: () {
                  if (productQuantity == controller.productCount.value) {
                    AppDialogs.showToast(message: 'الحد المسموح به هو $productQuantity');
                    return;
                  }
                  controller.increment();
                },
              ),
            ),
          ),
          AppSpacers.width10,
          Expanded(
            flex: 2,
            child: CustomBtnCompenent.main(
              iconPath: AppSvgAssets.cartIcon,
              text: isAvailable ? "إضافة إلى سلة الشراء" : "سيتوفر قريبا",
              onTap: isAvailable ? onAddToCart : () {},
            ),
          ),
        ],
      ),
    );
  }
}

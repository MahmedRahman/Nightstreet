import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/product_categories_view.dart';
import 'package:krzv2/component/views/product_filter_bottom_sheet_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/products_list_controller.dart';

class ProductsListView extends GetView<ProductsListController> {
  ProductsListView({Key? key});

  final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
  final double itemWidth = Get.width / 2;
  final cartController = Get.find<ShoppingCartController>();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: ProductListAppBar(
        onChanged: (productQueryParameters) {
          controller.queryParams.filter = productQueryParameters.filter;
          controller.queryParams.startPrice = productQueryParameters.startPrice;
          controller.queryParams.endPrice = productQueryParameters.endPrice;
          controller.queryParams.brandIds = productQueryParameters.brandIds;

          controller.productFilter();
        },
        controller: controller,
      ),
      onRefresh: controller.pullToRefresh,
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductCategoriesView(
              initalValue: (Get.arguments ?? '') as String,
              onTap: (String selectedCategoryId) {
                controller.queryParams.categoryId =
                    selectedCategoryId.toString();

                controller.productFilter();
              },
            ),
            AppSpacers.height10,
            Expanded(
              child: controller.obx(
                (List<ProductModel>? products) {
                  return productsList(
                    products: products,
                    controller: controller,
                  );
                },
                onLoading: onLoading(),
                onEmpty: AppPageEmpty.productSearchP(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView productsList({
    required List<ProductModel>? products,
    required ProductsListController controller,
  }) {
    return GridView.builder(
      itemCount: products?.length,
      controller: controller.scroll,
      padding: EdgeInsets.only(top: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight) / .35,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        final product = products?.elementAt(index);
        return GetBuilder<ProductFavoriteController>(
          init: ProductFavoriteController(),
          builder: (controller) {
            return ProductCardView(
              imageUrl: product!.image,
              isAvailable: product.quantity > 1,
              name: product.name,
              hasDiscount: product.oldPrice != 0,
              price: product.price.toString(),
              oldPrice: product.oldPrice.toString(),
              onAddToCartTapped: () {
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
              onFavoriteTapped: () {
                final favCon = Get.put<ProductFavoriteController>(
                  ProductFavoriteController(),
                );

                favCon.addRemoveProductFromFavorite(
                  productId: product.id,
                );
              },
              isFavorite:
                  controller.productFavoriteIds.value!.contains(product.id),
              onTap: () async {
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
  }

  GridView onLoading() {
    return GridView.builder(
      itemCount: 4,
      padding: EdgeInsets.only(top: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight) / .42,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        return ProductCardView.dummy().shimmer();
      },
    );
  }
}

class ProductListAppBar extends StatelessWidget implements PreferredSizeWidget {
  ProductListAppBar({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  final Function(ProductQueryParameters) onChanged;
  final ProductsListController controller;
  final authController = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      titleText: 'المنتجات',
      onBackTapped: () {
        Get.back(result: true);
      },
      actions: [
        if (authController.isLoggedIn || authController.isGuestUser)
          ShoppingCartIconView(),
        CustomIconButton(
          onTap: () {
            Get.bottomSheet(
              ProductFilterBottomSheetView(
                onChanged: onChanged,
                productQuery: controller.queryParams,
                maxPrice: KProductHighestPrice.value,
                onResetTapped: () {
                  controller.onInit();
                },
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}

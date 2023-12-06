import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/paginated_grid_view.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/pages/app_page_loading_more.dart';
import 'package:krzv2/component/views/product_search_app_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';

import '../controllers/product_search_controller.dart';

class ProductSearchView extends GetView<ProductSearchController> {
  ProductSearchView({Key? key}) : super(key: key);

  final searchTextController = TextEditingController();
  final cartController = Get.find<ShoppingCartController>();
  final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
  final double itemWidth = Get.width / 2;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: ProductSearchAppBarView(
        onBackTapped: () => Get.back(result: true),
        textEditingController: searchTextController,
        onSearchIconTapped: onSearchTapped,
        onChanged: (String query) {
          if (query.isEmpty) controller.resetSearchValues();
        },
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Obx(
          () {
            if (controller.searchQuery.isEmpty) return SizedBox();
            return PaginatedGridView<ProductModel>(
              controller: controller.pagingController.value,
              firstLoadingIndicator: firstLoadingIndicator(),
              itemBuilder: itemBuilder,
              onEmpty: AppPageEmpty.productSearchPP(),
            );
          },
        ),

        // controller.obx(
        //   (List<ProductModel>? products) {
        //     return productsList(
        //       products: products,
        //       controller: controller,
        //     );
        //   },
        //   onLoading: onLoading(),
        //   onEmpty: AppPageEmpty.productSearchP(),
        // ),
      ),
    );
  }

  Container firstLoadingIndicator() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * .38,
            child: ProductCardView.dummy().shimmer().paddingOnly(bottom: 10),
          ),
          SizedBox(
            height: Get.height * .38,
            child: ProductCardView.dummy().shimmer().paddingOnly(bottom: 10),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(_, ProductModel product, __) {
    return GetBuilder<ProductFavoriteController>(
      init: ProductFavoriteController(),
      builder: (controller) {
        return ProductCardView(
          imageUrl: product.image,
          isAvailable: product.quantity > 1,
          name: product.name,
          hasDiscount: product.oldPrice.toInt() != 0,
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
            final isGuest = Get.find<AuthenticationController>().isGuestUser;
            if (isGuest) {
              Get.find<ShoppingCartController>().addToGuestCart(
                productId: product.id.toString(),
                quantity: '1',
                isNew: true,
              );

              return;
            }
            Get.find<ShoppingCartController>().addToCart(
              productId: product.id.toString(),
              quantity: '1',
              isNew: true,
            );
          },
          onFavoriteTapped: () {
            if (Get.find<AuthenticationController>().isLoggedIn == false) {
              return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
            }
            final favCon = Get.put<ProductFavoriteController>(
              ProductFavoriteController(),
            );

            favCon.addRemoveProductFromFavorite(
              productId: product.id,
            );
          },
          isFavorite: controller.productFavoriteIds.value!.contains(
            product.id,
          ),
          onTap: () async {
            Get.toNamed(
              Routes.PRODUCT_DETAILS,
              arguments: product.id.toString(),
            );
          },
        );
      },
    );
  }

  onSearchTapped() {
    if (searchTextController.text.isEmpty) return;

    if (searchTextController.text == controller.searchQuery.value) return;

    controller.searchQuery.value = searchTextController.text;

    FocusScope.of(Get.context!).unfocus();

    controller.pagingController.value = PagingController(firstPageKey: 1);

    FocusScope.of(Get.context!).unfocus();

    controller.startSearch();
  }
}

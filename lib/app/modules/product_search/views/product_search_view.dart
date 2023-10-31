import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
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
  final cartController = Get.put(ShoppintCartController());
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
    );
  }

  GridView productsList({
    required List<ProductModel>? products,
    required ProductSearchController controller,
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
        return ProductCardView(
          imageUrl: product!.image,
          name: product.name,
          hasDiscount: product.oldPrice != 0,
          price: product.price.toString(),
          onAddToCartTapped: () {
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
          onFavoriteTapped: () {
            if (Get.put(AuthenticationController().isLoggedIn) == false) {
              return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
            }
            final favCon = Get.put<ProductFavoriteController>(
              ProductFavoriteController(),
            );
            controller.toggleFavorite(product.id);

            favCon.addRemoveProductFromFavorite(
              productId: product.id,
              onError: () {
                controller.toggleFavorite(product.id);
              },
            );
          },
          isFavorite: product.isFavorite,
          onTap: () async {
            final awaitId = await Get.toNamed(
              Routes.PRODUCT_DETAILS,
              arguments: product.id.toString(),
            );

            if (awaitId != null && awaitId != '') {
              controller.toggleFavorite(product.id);
            }
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

  onSearchTapped() {
    if (searchTextController.text.isEmpty) return;

    if (searchTextController.text == controller.searchQuery.value) return;

    controller.resetSearchValues();

    controller.searchQuery.value = searchTextController.text;

    FocusScope.of(Get.context!).unfocus();

    controller.getProducts();
  }
}

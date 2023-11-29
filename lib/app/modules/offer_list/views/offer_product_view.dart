import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_products_slider_controller.dart';
import 'package:krzv2/app/modules/offer_list/controllers/offer_product_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/paginated_grid_view.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_categories_list_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

RxInt KProductHighestPrice = 0.obs;

class OfferProductView extends GetView<OfferProductController> {
  OfferProductView({Key? key}) : super(key: key);
  final cartController = Get.find<ShoppingCartController>();
  final sliderController = Get.find<HomePageProductSliderController>();
  final productCategoriesController = Get.find<ProductCategoriesController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.mainColor,
      onRefresh: () async {
        productCategoriesController.onInit();
        controller.queryParams.categoryId = '';
        controller.onRefresh();
      },
      child: Column(
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
                initId: controller.queryParams.categoryId,
                categoriesList: categoriesList,
                onCategoryTapped: (int categoryId) async {
                  controller.queryParams.categoryId = categoryId.toString();

                  controller.pagingController.value =
                      PagingController(firstPageKey: 1);

                  controller.pageListener();
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
            child: Obx(
              () => PaginatedGridView<ProductModel>(
                controller: controller.pagingController.value,
                firstLoadingIndicator: firstLoadingIndicator(),
                itemBuilder: itemBuilder,
                onEmpty: AppPageEmpty.productSearchPP(),
              ),
            ),
          ),
        ],
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
}

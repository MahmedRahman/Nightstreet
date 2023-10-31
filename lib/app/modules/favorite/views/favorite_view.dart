import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/component/views/cards/clinic_card_view.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/tabs/base_switch_3_tap.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/branch_model.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';

class FavoriteView extends GetView {
  FavoriteView({Key? key}) : super(key: key);

  final selectedTapIndex = 0.obs;
  final productFavController = Get.find<ProductFavoriteController>();
  final offerFavController = Get.find<OfferFavoriteController>();
  final clinicFavController = Get.find<CliniFavoriteController>();

  @override
  Widget build(BuildContext context) {
    productFavController.resetPaginationValues();
    productFavController.getFavorite();
    return BaseScaffold(
      onRefresh: () async => refresh(),
      appBar: CustomAppBar(titleText: "المفضلة"),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            BaseSwitch3Tap(
              title1: "المنتجات",
              title2: "الخدمات",
              title3: "العيادات",
              Widget1: FavoriteProducts(),
              Widget2: FavoriteService(),
              Widget3: FavoriteClinic(),
              onTap: (int index) {
                selectedTapIndex.value = index;
                refresh();
              },
            )
          ],
        ),
      ),
    );
  }

  void refresh() {
    if (selectedTapIndex.value == 0) {
      productFavController.resetPaginationValues();
      productFavController.onInit();
      return;
    }
    if (selectedTapIndex.value == 1) {
      offerFavController.resetPaginationValues();
      offerFavController.onInit();
      return;
    }

    clinicFavController.resetPaginationValues();
    clinicFavController.onInit();
  }
}

class FavoriteProducts extends GetView<ProductFavoriteController> {
  final double itemHeight = (Get.height - kToolbarHeight);
  final double itemWidth = Get.width / 2;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (List<ProductModel>? productList) => GridView.builder(
        controller: controller.scroll,
        itemCount: productList?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight) / .38,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          final product = productList!.elementAt(index);
          return ProductCardView(
            imageUrl: product.image,
            name: product.name,
            hasDiscount: product.oldPrice != 0,
            price: product.price.toString(),
            onAddToCartTapped: () {
              final cartController = Get.put<ShoppintCartController>(
                ShoppintCartController(),
              );

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
              final favCon = Get.put<ProductFavoriteController>(
                ProductFavoriteController(),
              );
              controller.toggleFavorite(product.id);

              favCon.addRemoveProductFromFavorite(
                productId: product.id,
                onError: () {
                  controller.toggleFavorite(product.id);
                },
                onSuccess: () => controller.removeProductFromList(product.id),
              );
            },
            isFavorite: product.isFavorite,
            isLimitedQuantity: product.quantity < 10,
            onTap: () => Get.toNamed(
              Routes.PRODUCT_DETAILS,
              arguments: product.id.toString(),
            ),
          );
        },
      ),
      onLoading: GridView.builder(
        controller: controller.scroll,
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight) / .38,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, __) {
          return ProductCardView.dummy().shimmer();
        },
      ),
      onEmpty: AppPageEmpty.Favorite(
        description: 'قم بإضافة بعض المنتجات',
      ),
    );
  }
}

class FavoriteService extends GetView<OfferFavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (List<ServiceModel>? offers) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: offers?.length,
            itemBuilder: (context, index) {
              final offer = offers!.elementAt(index);
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: ServiceCardView(
                  imageUrl: offer.image,
                  name: offer.name,
                  hasDiscount: offer.oldPrice != 0,
                  price: offer.price.toString(),
                  oldPrice: offer.oldPrice.toString(),
                  onFavoriteTapped: () {
                    final favCon = Get.put<OfferFavoriteController>(
                      OfferFavoriteController(),
                    );
                    controller.toggleFavorite(offer.id);

                    favCon.addRemoveOfferFromFavorite(
                      offerId: offer.id,
                      onError: () {
                        controller.toggleFavorite(offer.id);
                      },
                      onSuccess: () => controller.removeOfferFromList(offer.id),
                    );
                  },
                  isFavorite: offer.isFavorite,
                  onTapped: () {},
                  rate: offer.totalRateAvg.toString(),
                  totalRate: offer.totalRateCount.toString(),
                ),
              );
            },
          );
        },
        onLoading: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: ServiceCardView.dummy().shimmer(),
            );
          },
        ),
        onEmpty: AppPageEmpty.Favorite(
          description: 'قم بإضافة بعض المنتجات',
        ),
      ),
    );
  }
}

class FavoriteClinic extends GetView<CliniFavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (List<BranchModel>? clinicList) => ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: clinicList?.length,
          itemBuilder: (context, index) {
            final clinic = clinicList?.elementAt(index);
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: ClinicCardView(
                isFavorite: clinic!.isFavorite,
                imageUrl: clinic.clinic.image,
                onTap: () {
                  
                },
                name: clinic.name,
                onFavoriteTapped: () {
                  controller.toggleFavorite(clinic.id);

                  controller.addRemoveBranchFromFavorite(
                    branchId: clinic.id,
                    onError: () {
                      controller.toggleFavorite(clinic.id);
                    },
                    onSuccess: () => controller.removeClinicFromList(clinic.id),
                  );
                },
                rate: clinic.totalRateAvg.toString(),
                totalRate: clinic.totalRateCount.toString(),
                distance: clinic.distance,
              ),
            );
          },
        ),
        onLoading: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: ClinicCardView.dummy().shimmer(),
            );
          },
        ),
        onEmpty: AppPageEmpty.Favorite(
          description: 'قم بإضافة بعض العيادات',
        ),
      ),
    );
  }
}

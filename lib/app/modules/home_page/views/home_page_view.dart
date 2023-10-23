import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_recommended_product_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_categories.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_slider_controller.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/home_app_bar_view.dart';
import 'package:krzv2/component/views/product_categories_list_view.dart';
import 'package:krzv2/component/views/product_service_button_view.dart';
import 'package:krzv2/component/views/products_hotizontal_list_view.dart';
import 'package:krzv2/component/views/recommended_services_list_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/service_categories_list_view.dart';
import 'package:krzv2/component/views/shimmers/home_categories_shimmer.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/product_model.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class HomePageView extends GetView {
  final productCategoriesController = Get.put(ProductCategoriesController());
  final serviceCategoriesController = Get.put(ServiceCategoriesController());
  final recommendedProductController = Get.put(RecommendedProductController());
  final servicesController = Get.put(HomePageServiceController());
  final sliderController = Get.put(HomePageSliderController());
  final bottomNavigationBarController = Get.put(MyBottomNavigationController());

  @override
  Widget build(BuildContext context) {
    recommendedProductController.onInit();
    servicesController.onInit();
    return WillPopScope(
      onWillPop: () async => false,
      child: BaseScaffold(
        appBar: HomeAppBarView(
          onCartTapped: () => Get.toNamed(Routes.SHOPPINT_CART),
          onNotificationTapped: () {
            Get.toNamed(Routes.notificationPage);
          },
          cartItemsCounter: 2,
          notificationCounter: 1,
        ),
        actions: [],
        body: ListView(
          padding: AppDimension.appPadding,
          children: [
            AppSpacers.height10,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductServiceButtonView.service(
                  onTap: () {
                    bottomNavigationBarController.currentIndex.value = 1;
                  },
                ),
                AppSpacers.width20,
                ProductServiceButtonView.product(
                  onTap: () {
                    bottomNavigationBarController.currentIndex.value = 2;
                  },
                ),
              ],
            ),
            AppSpacers.height16,
            serviceCategoriesController.obx(
              (servicesList) {
                return ServiceCategoriesListView(
                  serviceCategoriesList: servicesList,
                );
              },
              onLoading: CategoriesShimmer(
                categoryTitle: 'أقسام الخدمات',
              ),
            ),
            AppSpacers.height16,
            productCategoriesController.obx(
              (categoriesList) {
                return ProductCategoriesListView(
                  productCategoriesList: categoriesList,
                );
              },
              onLoading: CategoriesShimmer(
                categoryTitle: 'أقسام المنتجات',
              ),
            ),
            AppSpacers.height25,
            recommendedProductController.obx(
              (List<ProductModel>? productsList) {
                return ProductsHotizontalListView.recommended(
                  productsList: productsList ?? [],
                  onShowMoreTapped: () => Get.toNamed(Routes.PRODUCTS_LIST),
                  onAddToCartTapped: (int productId) {},
                  onFavoriteTapped: (int productId) {
                    final favCon = Get.put<ProductFavoriteController>(
                      ProductFavoriteController(),
                    );
                    recommendedProductController.toggleFavorite(productId);

                    favCon.addRemoveProductFromFavorite(
                      productId: productId,
                      onError: () {
                        recommendedProductController.toggleFavorite(productId);
                      },
                    );
                  },
                );
              },
              onLoading: ProductsHotizontalListView.recommended(
                productsList: [
                  ProductModel.dummyProduct,
                ],
                onShowMoreTapped: () {},
                onAddToCartTapped: (_) {},
                onFavoriteTapped: (_) {},
              ).shimmer(),
            ),
            AppSpacers.height25,
            servicesController.obx(
              (List<ServiceModel>? servicesList) {
                return RecommendedServicesListView(
                  onShowMoreTapped: () => Get.toNamed(Routes.SERVICES_SEARCH),
                  recommendedServicesList: servicesList ?? [],
                  onFavoriteTapped: (int serviceId) {
                    final favCon = Get.put<OfferFavoriteController>(
                      OfferFavoriteController(),
                    );
                    servicesController.toggleFavorite(serviceId);

                    favCon.addRemoveOfferFromFavorite(
                      offerId: serviceId,
                      onError: () {
                        servicesController.toggleFavorite(serviceId);
                      },
                    );
                  },
                );
              },
              onLoading: RecommendedServicesListView(
                onShowMoreTapped: () => Get.toNamed(Routes.SERVICES_SEARCH),
                recommendedServicesList: [
                  ServiceModel.dummyService,
                  ServiceModel.dummyService,
                ],
                onFavoriteTapped: (_) {},
              ).shimmer(),
            ),
            AppSpacers.height50,
          ],
        ),
      ),
    );
  }
}

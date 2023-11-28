import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_categories.dart';
import 'package:krzv2/app/modules/home_page_services/controllers/hom_page_service_slider_controller.dart';
import 'package:krzv2/app/modules/offer_list/controllers/offer_service_controller.dart';
import 'package:krzv2/component/paginated_list_view.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/home_page_service_categories_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/slider_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/service_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_spacers.dart';

RxInt KOfferHighestPrice = 0.obs;

class OfferServiceView extends GetView<OfferServiceController> {
  final controller = Get.find<OfferServiceController>();
  final sliderController = Get.find<HomePageServiceSliderController>();
  final serviceCategoriesController = Get.find<ServiceCategoriesController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacers.height10,
        sliderWidget(),
        SizedBox(
          height: 12,
        ),
        serviceCategories(),
        AppSpacers.height12,
        Expanded(
          child: Obx(
            () => PaginatedListView<ServiceModel>(
              controller: controller.pagingController.value,
              firstLoadingIndicator: Column(
                children: [
                  ServiceCardView.dummy().paddingOnly(bottom: 10).shimmer(),
                  ServiceCardView.dummy().shimmer(),
                ],
              ),
              itemBuilder: itemBuilder,
              onEmpty: AppPageEmpty.noServiceFound(),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(_, ServiceModel offer, __) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: GetBuilder<OfferFavoriteController>(
        init: OfferFavoriteController(),
        builder: (favoriteController) {
          return ServiceCardView(
            imageUrl: offer.image,
            name: offer.name,
            subTitle: offer.clinic.name,
            hasDiscount: offer.oldPrice != 0,
            price: offer.price.toString(),
            oldPrice: offer.oldPrice.toString(),
            onFavoriteTapped: () {
              if (Get.find<AuthenticationController>().isLoggedIn == false) {
                return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
              }
              final favCon = Get.find<OfferFavoriteController>();

              favCon.addRemoveOfferFromFavorite(
                offerId: offer.id,
              );
            },
            isFavorite: favoriteController.offerIsFavorite(offer.id),
            onTapped: () {
              Get.toNamed(
                Routes.SERVICE_DETAIL,
                arguments: offer.id.toString(),
              );
            },
            rate: offer.totalRateCount.toString(),
            totalRate: offer.totalRateAvg.toString(),
          );
        },
      ),
    );
  }

  Widget serviceCategories() {
    return serviceCategoriesController.obx(
      (categoriesList) {
        return HomePageServiceCategoriesView(
          categoriesList: categoriesList,
          onCategoryTapped: (int categoryId) async {
            if (categoryId.toString() == controller.categoryId.value) return;

            controller.categoryId.value = categoryId.toString();

            controller.pagingController.value =
                PagingController(firstPageKey: 1);

            controller.pageListener();
          },
        );
      },
      onLoading: HomePageServiceCategoriesView(
        categoriesList: [],
        onCategoryTapped: (int categoryId) {
          Get.toNamed(Routes.PRODUCTS_LIST);
        },
      ).shimmer(),
    );
  }

  Widget sliderWidget() {
    return sliderController.obx(
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_categories.dart';
import 'package:krzv2/app/modules/home_page_services/controllers/hom_page_service_slider_controller.dart';
import 'package:krzv2/app/modules/offer_list/controllers/offer_service_controller.dart';
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
  final controller = Get.put(OfferServiceController());
  final sliderController = Get.put(HomePageServiceSliderController());
  final serviceCategoriesController = Get.find<ServiceCategoriesController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        SizedBox(
          height: 12,
        ),
        serviceCategoriesController.obx(
          (categoriesList) {
            return HomePageServiceCategoriesView(
              categoriesList: categoriesList,
              onCategoryTapped: (int categoryId) async {
                if (categoryId.toString() == controller.categoryId.value)
                  return;

                controller.resetSearchValues();
                controller.categoryId.value = categoryId.toString();

                controller.getServices();
              },
            );
          },
          onLoading: HomePageServiceCategoriesView(
            categoriesList: [],
            onCategoryTapped: (int categoryId) {
              Get.toNamed(Routes.PRODUCTS_LIST);
            },
          ).shimmer(),
        ),
        AppSpacers.height12,
        Expanded(
          child: controller.obx(
            (List<ServiceModel>? servicesList) => ListView.builder(
              itemCount: servicesList?.length,
              controller: controller.scroll,
              itemBuilder: (context, index) {
                final service = servicesList?.elementAt(index);

                return GetBuilder<OfferFavoriteController>(
                  init: OfferFavoriteController(),
                  builder: (favoriteController) {
                    return ServiceCardView(
                      imageUrl: service!.image,
                      name: service.name,
                      hasDiscount: service.oldPrice != 0,
                      price: service.price.toString(),
                      oldPrice: service.oldPrice.toString(),
                      onFavoriteTapped: () {
                        if (Get.put(AuthenticationController().isLoggedIn) ==
                            false) {
                          return AppDialogs.showToast(
                              message: 'الرجاء تسجيل الدخول');
                        }

                        final favCon = Get.put<OfferFavoriteController>(
                          OfferFavoriteController(),
                        );

                        favCon.addRemoveOfferFromFavorite(
                          offerId: service.id,
                        );
                      },
                      rate: service.totalRateAvg.toString(),
                      totalRate: service.totalRateCount.toString(),
                      isFavorite:
                          favoriteController.offerIsFavorite(service.id),
                      onTapped: () {
                        Get.toNamed(
                          Routes.SERVICE_DETAIL,
                          arguments: service.id.toString(),
                        );
                      },
                    ).paddingOnly(bottom: 10);
                  },
                );
              },
            ),
            onLoading: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ServiceCardView.dummy()
                    .paddingOnly(bottom: 10)
                    .shimmer();
              },
            ),
            onEmpty: AppPageEmpty.serviceSearch(),
          ),
        )
      ],
    );
  }
}

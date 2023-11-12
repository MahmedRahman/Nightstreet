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
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

// RxInt KOfferHighestPrice = 0.obs;

// class OfferServiceView extends GetView<OfferServiceController> {
//   OfferServiceView() {
//     controller.resetSearchValues();
//     controller.onInit();
//   }
//   final controller = Get.find<OfferServiceController>();
//   final sliderController = Get.find<HomePageServiceSliderController>();
//   final serviceCategoriesController = Get.find<ServiceCategoriesController>();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AppSpacers.height10,
//         sliderWidget(),
//         SizedBox(
//           height: 12,
//         ),
//         serviceCategories(),
//         AppSpacers.height12,
//         Expanded(
//           child: controller.obx(
//             (List<ServiceModel>? servicesList) => ListView.builder(
//               itemCount: servicesList?.length,
//               controller: controller.scroll,
//               itemBuilder: (context, index) {
//                 final service = servicesList?.elementAt(index);

//                 return GetBuilder<OfferFavoriteController>(
//                   init: OfferFavoriteController(),
//                   builder: (favoriteController) {
//                     return ServiceCardView(
//                       imageUrl: service!.image,
//                       name: service.name,
//                       hasDiscount: service.oldPrice != 0,
//                       price: service.price.toString(),
//                       oldPrice: service.oldPrice.toString(),
//                       onFavoriteTapped: () {
//                         if (Get.find<AuthenticationController>().isLoggedIn ==
//                             false) {
//                           return AppDialogs.showToast(
//                               message: 'الرجاء تسجيل الدخول');
//                         }

//                         final favCon = Get.put<OfferFavoriteController>(
//                           OfferFavoriteController(),
//                         );

//                         favCon.addRemoveOfferFromFavorite(
//                           offerId: service.id,
//                         );
//                       },
//                       rate: service.totalRateAvg.toString(),
//                       totalRate: service.totalRateCount.toString(),
//                       isFavorite:
//                           favoriteController.offerIsFavorite(service.id),
//                       onTapped: () {
//                         Get.toNamed(
//                           Routes.SERVICE_DETAIL,
//                           arguments: service.id.toString(),
//                         );
//                       },
//                     ).paddingOnly(bottom: 10);
//                   },
//                 );
//               },
//             ),
//             onLoading: ListView.builder(
//               itemCount: 4,
//               itemBuilder: (context, index) {
//                 return ServiceCardView.dummy()
//                     .paddingOnly(bottom: 10)
//                     .shimmer();
//               },
//             ),
//             onEmpty: AppPageEmpty.serviceSearch(),
//           ),
//         )
//       ],
//     );
//   }

//   Widget serviceCategories() {
//     return serviceCategoriesController.obx(
//       (categoriesList) {
//         return HomePageServiceCategoriesView(
//           categoriesList: categoriesList,
//           onCategoryTapped: (int categoryId) async {
//             if (categoryId.toString() == controller.categoryId.value) return;

//             controller.resetSearchValues();
//             controller.categoryId.value = categoryId.toString();

//             controller.getServices();
//           },
//         );
//       },
//       onLoading: HomePageServiceCategoriesView(
//         categoriesList: [],
//         onCategoryTapped: (int categoryId) {
//           Get.toNamed(Routes.PRODUCTS_LIST);
//         },
//       ).shimmer(),
//     );
//   }

//   Widget sliderWidget() {
//     return sliderController.obx(
//       (slidersList) {
//         return SliderView(
//           images: slidersList!.map((slider) => slider.image).toList(),
//         );
//       },
//       onLoading: Container(
//         height: 150,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.black,
//         ),
//       ).shimmer(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
// import 'package:krzv2/component/views/cards/service_card_view.dart';
// import 'package:krzv2/component/views/custom_dialogs.dart';
// import 'package:krzv2/routes/app_pages.dart';
// import 'package:krzv2/services/auth_service.dart';
// import 'package:krzv2/web_serives/model/api_response_model.dart';
// import 'package:krzv2/web_serives/web_serives.dart';

RxInt KOfferHighestPrice = 0.obs;

class OfferServiceController extends GetxController with StateMixin<List> {
  @override
  void onInit() {
    getOffersService();
    super.onInit();
  }

  void getOffersService() async {
    ResponseModel responseModel = await WebServices().getOffersService();
    if (responseModel.data["success"]) {
      if ((responseModel.data["data"]["data"] as List).length == 0) {
        change(null, status: RxStatus.empty());
        return;
      }
      KOfferHighestPrice.value = responseModel.data["data"]["highest_price"];
      change(responseModel.data["data"]["data"], status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}

class OfferServiceView extends GetView<OfferServiceController> {
  // final controller = Get.put(OfferServiceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (snapshot) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: GetBuilder<OfferFavoriteController>(
                  init: OfferFavoriteController(),
                  builder: (favoriteController) {
                    return ServiceCardView(
                      name: snapshot[index]["name"].toString(),
                      imageUrl: snapshot[index]["image"].toString(),
                      price: snapshot[index]["price"].toString(),
                      oldPrice: snapshot[index]["old_price"].toString(),
                      hasDiscount: false,
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
                          offerId: snapshot[index]["id"] as int,
                        );
                      },
                      onTapped: () async {
                        Get.toNamed(
                          Routes.SERVICE_DETAIL,
                          arguments: snapshot[index]["id"].toString(),
                        );
                      },
                      rate: snapshot[index]["total_rate_count"].toString(),
                      totalRate: snapshot[index]["total_rate_avg"].toString(),
                      isFavorite: favoriteController
                          .offerIsFavorite(snapshot[index]["id"]),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

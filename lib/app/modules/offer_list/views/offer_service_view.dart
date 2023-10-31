import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

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
      change(responseModel.data["data"]["data"], status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error());
  }
}

class OfferServiceView extends GetView<OfferServiceController> {
  final controller = Get.put(OfferServiceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx((snapshot) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: ServiceCardView(
                name: snapshot[index]["name"].toString(),
                imageUrl: snapshot[index]["image"].toString(),
                price: snapshot[index]["price"].toString(),
                oldPrice: snapshot[index]["old_price"].toString(),
                hasDiscount: false,
                onFavoriteTapped: () {
                  if (Get.put(AuthenticationController().isLoggedIn) == false) {
                    return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
                  }

                  final favCon = Get.put<OfferFavoriteController>(
                    OfferFavoriteController(),
                  );

                  snapshot[index]["is_favorite"] =
                      !snapshot[index]["is_favorite"];
                  controller.update();

                  favCon.addRemoveOfferFromFavorite(
                    offerId: snapshot[index]["id"] as int,
                    onError: () {
                      snapshot[index]["is_favorite"] =
                          !snapshot[index]["is_favorite"];
                      controller.update();
                    },
                  );
                },
                onTapped: () async {
                  final awaitId = await Get.toNamed(
                    Routes.SERVICE_DETAIL,
                    arguments: snapshot[index]["id"].toString(),
                  );

                  if (awaitId != null && awaitId != '') {
                    snapshot[index]["is_favorite"] =
                        !snapshot[index]["is_favorite"];
                    controller.update();
                  }
                },
                rate: snapshot[index]["total_rate_count"].toString(),
                totalRate: snapshot[index]["total_rate_avg"].toString(),
                isFavorite: snapshot[index]["is_favorite"],
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductFavoriteController>(
      ProductFavoriteController(),
    );
    Get.put<OfferFavoriteController>(
      OfferFavoriteController(),
    );
    Get.put<CliniFavoriteController>(
      CliniFavoriteController(),
    );
  }
}

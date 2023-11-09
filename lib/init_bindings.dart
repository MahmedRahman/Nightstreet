import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_service_view.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/services/static_page_service.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController());
    Get.put(ProductFavoriteController());
    Get.put(OfferFavoriteController());
    Get.put(CliniFavoriteController());
    Get.put(StaticPageService());
    Get.put(MyBottomNavigationController());
    Get.put(SplashController());
    Get.put(AppointmentController());
    Get.put(OfferServiceController());
    Get.put(OfferProductController());
    Get.put(ShoppingCartController());
  }
}

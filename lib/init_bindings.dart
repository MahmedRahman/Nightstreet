import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_service_view.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/main.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/services/firebase_messaging_service.dart';
import 'package:krzv2/services/static_page_service.dart';
import 'package:krzv2/web_serives/api_manger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
    Get.put(ShoppintCartController());
  }
}

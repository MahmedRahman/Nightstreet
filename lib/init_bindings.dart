import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/market_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_product_categories_controller.dart';
import 'package:krzv2/app/modules/home_page/controllers/home_page_service_categories.dart';
import 'package:krzv2/app/modules/home_page_products/controllers/home_page_products_slider_controller.dart';
import 'package:krzv2/app/modules/home_page_products/views/home_page_products_view.dart';
import 'package:krzv2/app/modules/home_page_services/controllers/hom_page_service_slider_controller.dart';
import 'package:krzv2/app/modules/home_page_services/controllers/home_page_services_controller.dart';
import 'package:krzv2/app/modules/offer_list/controllers/offer_product_controller.dart';
import 'package:krzv2/app/modules/offer_list/controllers/offer_service_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/services/app_version_service.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/services/static_page_service.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppVersionService());
    Get.put(AuthenticationController());
    Get.put(ProductFavoriteController());
    Get.put(OfferFavoriteController());
    Get.put(CliniFavoriteController());
    Get.put(MarketFavoriteController());
    Get.put(StaticPageService());
    Get.put(MyBottomNavigationController());
    Get.put(
      ShoppingCartController(),
      permanent: true,
    );
    Get.put(SplashController());
    Get.put(AppointmentController());
    Get.put(OfferServiceController());
    Get.put(OfferProductController());
    Get.put(ServiceCategoriesController());
    Get.put(ProductCategoriesController());
    Get.put(
      HomePageServiceSliderController(),
      permanent: true,
    );
    Get.put(
      HomePageProductSliderController(),
      permanent: true,
    );

    Get.put(MarketController());
    Get.put(HomePageServicesController());
  }
}

// @dart=2.12
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_service_view.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/services/firebase_messaging_service.dart';
import 'package:krzv2/services/static_page_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeDateFormatting('ar', null);
  await PushNotificationService().setupInteractedMessage();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://5019d3dc513f036f269fc73c18c719cd@o4504808028569600.ingest.sentry.io/4506109723148288';
    },
    // Init your App.
    appRunner: () {
      // print('isLoggedIn => ${Get.find<AuthenticationController>().isLoggedIn}');
      runApp(
        DevicePreview(
          //enabled: !kReleaseMode,
          enabled: false,
          builder: (context) => GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(Get.context!);
              currentFocus.unfocus();
            },
            child: GetMaterialApp(
              title: 'كرز',
              debugShowCheckedModeBanner: false,
              textDirection: TextDirection.rtl,
              theme: ThemeData(
                fontFamily: "effra",
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
              ),
              locale: const Locale('ar_EG'),
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              builder: EasyLoading.init(),
              initialBinding: BindingsBuilder(
                () {
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
                  // Get.put(AppVersionService());
                  // Get.put(ComplaintController());
                },
              ),
              navigatorObservers: [
                SentryNavigatorObserver(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    requestPermission();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print(
            'title => ${message.notification?.title ?? "empty title"}, message => ${message.notification?.body ?? "empty body"}');
      },
    );
    super.initState();
  }

  void requestPermission() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user done permission');
      PushNotificationService().getFCMToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
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
          // builder: ((context, child) {
          //   EasyLoading.init();
          //   return ApiConfig.KDebugFlg
          //       ? Scaffold(
          //           appBar: DebugView(),
          //           body: child!,
          //         )
          //       : child!;
          // }),
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
    );
  }
}

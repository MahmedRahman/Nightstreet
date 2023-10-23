import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/services/firebase_messaging_service.dart';
import 'package:krzv2/services/internet_connection.dart';
import 'package:krzv2/services/static_page_service.dart';

import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await initializeDateFormatting('ar', null);
  await PushNotificationService().setupInteractedMessage();

  runApp(
    DevicePreview(
      //enabled: !kReleaseMode,
      enabled: true,
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
              Get.put(StaticPageService());
              Get.put(MyBottomNavigationController());
              Get.put(SplashController());
              // Get.put(AppVersionService());
              // Get.put(ComplaintController());
            },
          ),
        ),
      ),
    ),
  );
}

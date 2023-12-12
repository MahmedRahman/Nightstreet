import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/init_bindings.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_booking_h_view.dart';
import 'package:krzv2/web_serives/view/api_debug_view.dart';
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
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   home: Scaffold(
    //     floatingActionButton: Padding(
    //       padding: const EdgeInsets.only(bottom: 60),
    //       child: FloatingActionButton(
    //         child: Icon(Icons.add),
    //         onPressed: () {
    //           Get.bottomSheet(DebugView());
    //         },
    //       ),
    //     ),
    //     body: DevicePreview(
    //       enabled: false,
    //       builder: (context) => GestureDetector(
    //         onTap: () {
    //           FocusScopeNode currentFocus = FocusScope.of(Get.context!);
    //           currentFocus.unfocus();
    //         },
    //         child: GetMaterialApp(
    //           title: 'كرز',
    //           debugShowCheckedModeBanner: false,
    //           textDirection: TextDirection.rtl,
    //           theme: ThemeData(
    //             useMaterial3: false,
    //             fontFamily: "effra",
    //             scaffoldBackgroundColor: Colors.white,
    //             appBarTheme: const AppBarTheme(
    //               systemOverlayStyle: SystemUiOverlayStyle.dark,
    //             ),
    //           ),
    //           locale: const Locale('ar_EG'),
    //           // home: BlackoutDatesUpdation(),
    //           initialRoute: AppPages.INITIAL,
    //           getPages: AppPages.routes,
    //           builder: EasyLoading.init(),
    //           initialBinding: InitBindings(),
    //           navigatorObservers: [
    //             SentryNavigatorObserver(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return DevicePreview(
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
            useMaterial3: false,
            fontFamily: "effra",
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
          ),
          locale: const Locale('ar_EG'),
          // home: MyTestScreen(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
          initialBinding: InitBindings(),

          navigatorObservers: [
            SentryNavigatorObserver(),
          ],
        ),
      ),
    );
  }
}

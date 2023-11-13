import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/init_bindings.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/firebase_messaging_service.dart';
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
      PushNotificationService().getFCMToken();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          initialBinding: InitBindings(),
          navigatorObservers: [
            SentryNavigatorObserver(),
          ],
        ),
      ),
    );
  }
}

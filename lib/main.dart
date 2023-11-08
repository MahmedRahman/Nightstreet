// @dart=2.12
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:krzv2/app.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_product_view.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_service_view.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/app/modules/splash/splash_page.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/firebase_options.dart';

import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/services/firebase_messaging_service.dart';
import 'package:krzv2/services/static_page_service.dart';
import 'package:krzv2/web_serives/api_manger.dart';
import 'package:krzv2/web_serives/response_trake_page.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'routes/app_pages.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  await initializeDateFormatting('ar', null);
  // await PushNotificationService().setupInteractedMessage();

  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://5019d3dc513f036f269fc73c18c719cd@o4504808028569600.ingest.sentry.io/4506109723148288';
    },
    appRunner: () {
      runApp(
        MyApp(),
      );
    },
  );
}

PreferredSize DebugView() {
  return PreferredSize(
    preferredSize: Size.fromHeight(220),
    child: Scaffold(
      appBar: AppBar(
        title: Text("Debug"),
        actions: [
          IconButton(
            onPressed: () {
              ResponseModelList.clear();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          //color: Colors.red,
          child: Obx(() {
            return ListView(
              //reverse: true,
              children: List.generate(ResponseModelList.length, (index) {
                return Card(
                  color: ResponseModelList.elementAt(index).statusCode == 200
                      ? Colors.green.withOpacity(.1)
                      : Colors.red.withOpacity(.1),
                  child: ListTile(
                    leading: (ResponseModelList.elementAt(index).httpRequest == HTTPRequestEnum.GET)
                        ? Text(
                            "Get",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            "Post",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.copy_all),
                    ),
                    title: Text(
                      ResponseModelList.elementAt(index).url.toString(),
                      maxLines: 2,
                      style: TextStyle(),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    ),
  );
}

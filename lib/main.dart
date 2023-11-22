// @dart=2.12
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:krzv2/app.dart';
import 'package:krzv2/firebase_options.dart';
import 'package:krzv2/services/firebase_messaging_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  await initializeDateFormatting('ar', null);
  PushNotificationService().setupInteractedMessage();

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

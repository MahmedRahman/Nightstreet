import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      tools: [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Night Street",
          locale: Locale(
            'ar',
            'SA',
          ),
          initialRoute: AppPages.INITIAL,
          theme: ThemeData(
              fontFamily: 'Montserrat',
              textTheme: TextTheme(),
              useMaterial3: false,
              primaryColor: Colors.red,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
              )),
          getPages: AppPages.routes,
        ),
      ),
    ),
  );
}

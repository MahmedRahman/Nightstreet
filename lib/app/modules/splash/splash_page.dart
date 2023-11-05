import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/google_map/controllers/google_map_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class AppGlobal {
  static var KSettingData;
}

class SplashController extends GetxController with StateMixin {
  final authenticationController = Get.find<AuthenticationController>();
  final cartController = Get.put<ShoppintCartController>(
    ShoppintCartController(),
  );
  final mapController = Get.put<GoogleMapViewController>(
    GoogleMapViewController(),
  );

  @override
  void onInit() {
    Init();
    super.onInit();
  }

  void Init() async {
    change(null, status: RxStatus.loading());
    mapController.askPermissionAndGetCurrentLocation();

    ResponseModel responseModel = await WebServices().getSetting();

    if (responseModel.data["success"]) {
      AppGlobal.KSettingData = responseModel.data["data"];
    }

    if (authenticationController.isLoggedIn) {
      authenticationController.getProfile();
      cartController.onInit();
      Get.offAllNamed(Routes.LAYOUT);
      return;
    }

    if (authenticationController.isGuestUser) {
      cartController.onInit();
      Get.offAllNamed(Routes.LAYOUT);
      return;
    }

    Get.offAllNamed(Routes.LAYOUT);
    change([], status: RxStatus.success());

    Timer(
      const Duration(seconds: 12),
      () {},
    );
  }
}

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (snapshot) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff7C3A5B),
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  "assets/svg/splash_logo.svg",
                ),
              )
            ],
          ),
        );
      },
      onLoading: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff7C3A5B),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/splash_logo.svg",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CircularProgressIndicator()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

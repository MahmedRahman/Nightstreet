import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class UpdatePhoneController extends GetxController {
  Future<void> sendVerificationCode({
    required String phoneNumber,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().sendOtpUpdatePhone(
      phone: phoneNumber,
    );

    EasyLoading.dismiss();
    if (response.data["success"] == false) {
      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );

      return;
    }
    AppDialogs.showToast(
      message: response.data["message"].toString(),
    );
    Get.toNamed(
      Routes.UPDATE_PHONE_OTP,
      arguments: phoneNumber,
    );
  }

  Future<void> updatePhone({
    required String phoneNumber,
    required String verificationCode,
    required Function() onError,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().updatePhone(
      phone: phoneNumber,
      code: verificationCode,
    );
    EasyLoading.dismiss();

    if (response.data["success"] == false) {
      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );

      onError();
      return;
    }

    AppDialogs.showToast(
      message: response.data["message"].toString(),
    );

    await Future.delayed(
      const Duration(seconds: 2),
      () async {
        final authController = Get.find<AuthenticationController>();
        await authController.getProfile();
        return Get.offAndToNamed(Routes.LAYOUT);
      },
    );
  }
}

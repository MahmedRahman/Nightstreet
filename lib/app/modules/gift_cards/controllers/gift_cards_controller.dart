import 'package:get/get.dart';
import 'package:krzv2/app/modules/gift_cards/views/payment_page.dart';
import 'package:krzv2/app/modules/payment_bank/payment_page_new.dart';
import 'package:krzv2/app/modules/payment_bank/payment_success_page.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/web_serives/api_manger.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class GiftCardsController extends GetxController with StateMixin {
  //final selectedIndex = 0.obs;

  @override
  void onInit() {
    change([], status: RxStatus.success());
    getCouponsThemes();
    super.onInit();
  }

  void getCouponsThemes() async {
    change([], status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().getCouponsThemes();
    if (responseModel.data["success"]) {
      if ((responseModel.data["data"] as List).length == 0) {
        change([], status: RxStatus.empty());
        return;
      }
      change(responseModel.data["data"], status: RxStatus.success());
      return;
    }
    change([], status: RxStatus.error());
  }

  void setCoupons({
    required String message,
    required String amount,
    required String paymentType,
    required String fullName,
    required String phone,
    required String themeId,
  }) async {
    change([], status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().setCoupons(
      message: message,
      amount: amount,
      paymentType: paymentType,
      fullName: fullName,
      phone: phone,
      themeId: themeId,
    );

    if (responseModel.data["success"]) {
      // if ((responseModel.data["data"] as List).length == 0) {
      //   change([], status: RxStatus.empty());
      //   return;
      // }

      // Get.to(paymentPage(
      //   PaymentUrl: responseModel.data["data"],
      // ));

      Get.to(
        AppPaymentNewPage(
          PaymentUrl: responseModel.data["data"],
          FailedPaymentUrl: "${ApiConfig.baseUrl}/coupons/rajhi-failed-callback",
          SuccessPaymentUrl: "${ApiConfig.baseUrl}/coupons/rajhi-success-callback",
          onFailed: () {
            AppDialogs.showToast(message: "خطاء في عمليه الدفع");
            Get.back();
            return;
          },
          onSuccess: () {
            Get.offAll(PaymentSuccessPage());
          },
        ),
      );
      //AppDialogs.giftCartPaymentSuccess();
      //change(responseModel.data["data"], status: RxStatus.success());
      return;
    }
    change([], status: RxStatus.error());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

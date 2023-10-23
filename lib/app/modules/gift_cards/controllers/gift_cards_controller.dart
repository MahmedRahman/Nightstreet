import 'package:get/get.dart';
import 'package:krzv2/app/modules/gift_cards/views/payment_page.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
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

      Get.to(paymentPage(
        PaymentUrl: responseModel.data["data"],
      ));
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

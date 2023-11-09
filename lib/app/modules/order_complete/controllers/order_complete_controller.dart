import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/payment_bank/payment_page_new.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/order_payment_success_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_manger.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OrderCompleteController extends GetxController {
  Future<void> requestOrder({
    required String partnerId,
    required String addressId,
    required String paymentMethod,
  }) async {
    EasyLoading.show();

    ResponseModel response = await WebServices().requestOrder(
      partnerId: partnerId,
      addressId: addressId,
      paymentMethod: paymentMethod,
    );
    EasyLoading.dismiss();
    final authController = Get.find<AuthenticationController>();
    final cartController = Get.find<ShoppingCartController>();
    print('response data => ${response.data}');

    if (response.data["success"] == false) {
      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );

      return;
    }

    if (paymentMethod == "card" || paymentMethod == "wallet_card") {
      // Get.to(
      //   OrderPaymentView(
      //     PaymentUrl: response.data["data"],
      //   ),
      // );

      Get.to(
        AppPaymentNewPage(
          PaymentUrl: response.data["data"],
          FailedPaymentUrl: "${ApiConfig.baseUrl}/orders/rajhi-failed-callback",
          SuccessPaymentUrl:
              "${ApiConfig.baseUrl}/orders/rajhi-success-callback",
          onFailed: () {
            AppDialogs.showToast(message: "خطا في عمليه الدفع");
            Get.back();
            return;
          },
          onSuccess: () {
            Get.offAll(OrderPaymentSuccessView());
            cartController.onInit();
            authController.getProfile();
          },
        ),
      );
      return;
    }

    authController.getProfile();
    cartController.onInit();
    AppDialogs.oderConfirmed();
  }
}

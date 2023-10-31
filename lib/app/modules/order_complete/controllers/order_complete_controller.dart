import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/order_payment_view.dart';
import 'package:krzv2/component/views/toast_component.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
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
    final cartController = Get.find<ShoppintCartController>();
    print('response data => ${response.data}');

    if (response.data["success"] == false) {
      showToast(
        message: response.data["message"].toString(),
      );

      return;
    }

    if (paymentMethod == "card" || paymentMethod == "wallet_card") {
      Get.to(
        OrderPaymentView(
          PaymentUrl: response.data["data"],
        ),
      );
      return;
    }

    authController.getProfile();
    cartController.onInit();
    AppDialogs.oderConfirmed();
  }
}

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OrderReviewController extends GetxController {
  rateOrderProduct({
    required String orderId,
    required String productId,
    required String rate,
    String? message,
  }) async {
    EasyLoading.show();

    ResponseModel responseModel = await WebServices().rateOrderProduct(
      orderId: orderId,
      productId: productId,
      rate: rate,
      message: message,
    );
    EasyLoading.dismiss();

    if (responseModel.data["success"]) {
      AppDialogs.showToast(message: responseModel.data["message"]);

      return;
    }
    AppDialogs.showToast(message: responseModel.data["message"]);
  }
}

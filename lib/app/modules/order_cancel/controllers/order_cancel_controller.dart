import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/orders_list/controllers/orders_list_controller.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OrderCancelController extends GetxController with StateMixin {
  final authController = Get.find<AuthenticationController>();
  @override
  void onInit() {
    orderCancelReasons();
    super.onInit();
  }

  void orderCancelReasons() async {
    change(null, status: RxStatus.loading());
    ResponseModel responseModel = await WebServices().orderCancelReasons();

    if (responseModel.data["success"]) {
      final List<dynamic> categoryDataList = responseModel.data["data"];

      if (categoryDataList.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(categoryDataList, status: RxStatus.success());
      return;
    }

    change([], status: RxStatus.error(responseModel.data["message"]));
  }

  cancelOrders({
    required String orderId,
    required List<String> reasondIds,
  }) async {
    EasyLoading.show();

    ResponseModel responseModel = await WebServices().cancelOrder(
      orderId: orderId.toString(),
      reasondIds: reasondIds,
    );
    EasyLoading.dismiss();

    if (responseModel.data["success"]) {
      AppDialogs.showToast(message: responseModel.data["message"]);
      authController.getProfile();

      Get.find<OrdersListController>().refreshList();

      // Get.toNamed(Routes.ORDERS_LIST);
      Get.back(closeOverlays: true);

      return;
    }
    AppDialogs.showToast(message: responseModel.data["message"]);
  }
}

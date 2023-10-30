import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/order_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OrderDetailsController extends GetxController
    with StateMixin<OrderModel> {
  @override
  void onInit() {
    getOrderDetails();
    super.onInit();
  }

  getOrderDetails() async {
    change(null, status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getOrderDetails(
      orderId: Get.arguments as int,
    );

    if (responseModel.data["success"]) {
      final OrderModel fetchedData =
          OrderModel.fromJson(responseModel.data['data']);

      change(fetchedData, status: RxStatus.success());

      return;
    }
    change(responseModel.data['message'], status: RxStatus.error());
  }

  reOrder({required int orderId}) async {
    EasyLoading.show();

    ResponseModel responseModel = await WebServices().reOrder(
      orderId: orderId,
    );
    EasyLoading.dismiss();

    if (responseModel.data["success"]) {
      final bottomNavigationController =
          Get.find<MyBottomNavigationController>();

      AppDialogs.showToast(message: responseModel.data["message"]);

      bottomNavigationController.changePage(4);
      Get.toNamed(Routes.ORDERS_LIST);

      return;
    }
    AppDialogs.showToast(message: responseModel.data["message"]);
  }
}

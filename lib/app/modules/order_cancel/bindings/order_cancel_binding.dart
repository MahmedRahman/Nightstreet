import 'package:get/get.dart';

import '../controllers/order_cancel_controller.dart';

class OrderCancelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderCancelController>(
      () => OrderCancelController(),
    );
  }
}

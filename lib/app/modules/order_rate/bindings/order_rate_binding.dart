import 'package:get/get.dart';

import '../controllers/order_rate_controller.dart';

class OrderRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRateController>(
      () => OrderRateController(),
    );
  }
}

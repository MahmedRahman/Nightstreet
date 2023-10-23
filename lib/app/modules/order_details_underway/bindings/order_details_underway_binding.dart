import 'package:get/get.dart';

import '../controllers/order_details_underway_controller.dart';

class OrderDetailsUnderwayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsUnderwayController>(
      () => OrderDetailsUnderwayController(),
    );
  }
}

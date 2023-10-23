import 'package:get/get.dart';

import '../controllers/order_complete_controller.dart';

class OrderCompleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderCompleteController>(
      () => OrderCompleteController(),
    );
  }
}

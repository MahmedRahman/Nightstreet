import 'package:get/get.dart';

import '../controllers/complete_order_controller.dart';

class CompleteOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteOrderController>(
      () => CompleteOrderController(),
    );
  }
}
